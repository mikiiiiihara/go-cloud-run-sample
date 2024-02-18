provider "google" {
  project     = var.project_id
  region      = var.default_region
  credentials = file(var.credentials_key_path)
}

module "project_services" {
  source                      = "../modules/apis"
  project_id = var.project_id
  enable_apis = var.enable_apis
}

resource "google_cloud_run_service" "cloud_run" {
  name     = "api-production-jpe"
  location = "asia-northeast1" # コンテナイメージと同じリージョンを指定
  project  = var.project_id

  template {
    spec {
      containers {
        image = "asia.gcr.io/${var.project_id}/api-production-jpe"
      }
    }
    metadata {
    annotations = {
            "autoscaling.knative.dev/minScale" = var.cloud_run_min_scale,
            "autoscaling.knative.dev/maxScale" = var.cloud_run_max_scale,
            "run.googleapis.com/client-name"       = "gcloud",
            "run.googleapis.com/client-version"    = "464.0.0",
            "run.googleapis.com/startup-cpu-boost" = true
        }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
  timeouts {}
  
}


resource "google_artifact_registry_repository" "my_repository" {
  provider = google
  location = var.default_region
  repository_id = var.project_id
  description = "Docker repository"
  format = "DOCKER"
  
  depends_on = [module.project_services]
}

# 事前にサービスアカウントを作成しておく必要がる
# https://qiita.com/takengineer1216/items/40db479a49d77c07b07b
resource "google_project_iam_member" "cloudbuild_cloudrun_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${var.cloudbuild_service_account}"

  depends_on = [module.project_services]
}