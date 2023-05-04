variable "env" {}
variable "project" {}
variable "vpc_id" {
  description = "ID of the VPC in which security resources are deployed"
  type        = string
  default      = "vpc-0e5c8768b10a0cf3c"
}