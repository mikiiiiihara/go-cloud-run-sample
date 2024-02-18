variable "credentials_key_path" {
    description = "credentials key path"
    type        = string
}

variable "project_id" {
  description = "project id"
  type        = string
}

variable "default_region" {
  description = "The default region for resources"
    type        = string
}

variable "cloudbuild_service_account" {
  description = "The service account email of Cloud Build."
  type        = string
}

variable "enable_apis" {
  type    = bool
  default = true
}

variable "cloud_run_min_scale" {
  description = "min scale of Cloud Run Instance"
  type    = number
  default = 0
}

variable "cloud_run_max_scale" {
  description = "max scale of Cloud Run Instance"
  type    = number
  default = 100
}