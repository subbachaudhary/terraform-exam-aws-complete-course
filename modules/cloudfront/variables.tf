variable "env" {}
variable "project_name" {}
variable "domain_name" {}
variable "bucket_names" {}
variable "user_bucket_public_url" {}
variable "admin_bucket_public_url" {}
variable "bucket_public_urls" {
  #   type = map(object({}))
}
variable "bucket_info" {}
variable "front_certificate_arn" {}