variable "env" {
  type        = string
  description = "Environment for which the infrastructure is being created"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
}

#Frontend Dashboard
#######################################################
variable "bucket_names" {
  type    = list(string)
  default = ["admin", "user"]
}



#Networking Related.
###########################################
variable "vpc_cidr" {
  type        = string
  description = "CIDR Range for our VPC"
  default     = "192.168.0.0/16"
}
variable "public_subnet_cidr_blocks" {
  default     = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  type        = list(any)
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  default     = ["192.168.4.0/24", "192.168.5.0/24", "192.168.6.0/24"]
  type        = list(any)
  description = "List of private subnet CIDR blocks"
}

variable "availability_zones" {
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  type        = list(any)
  description = "List of availability zones"
}

variable "region" {
  type        = string
  description = "Region of the resources to be created."
  default     = "us-east-1"
}

##########################################################

#Certificates
variable "domain_name" {
  type        = string
  description = "Name of the domain for the certificates"
}

variable "zone_name" {
  type        = string
  description = "Name of the hosted zone."
}

variable "api_subject_alternative_names" {
  type        = list(string)
  description = "Alternative names for the API domains."
}
variable "frontend_subject_alternative_names" {
  type        = list(string)
  description = "Alternative names for the frontend domains."
}

variable "api_domain" {
  type        = string
  description = "This sub domain/domain is used for request mapping."
}

variable "api_solution_stack_name" {
  type        = string
  description = "This is the api solution stack name"
}