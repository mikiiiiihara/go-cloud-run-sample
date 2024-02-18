module "project_services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = "14.2.1"
  disable_services_on_destroy = false
  project_id                  = var.project_id
  enable_apis                 = var.enable_apis
  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "artifactregistry.googleapis.com"
    # serviceusageは手動で有効化する必要がある
    # "serviceusage.googleapis.com"
  ]
}