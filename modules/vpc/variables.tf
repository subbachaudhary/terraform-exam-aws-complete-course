variable "env" {}
variable "project" {}
variable "cidr_block" {
    description = "defining cidr_block name"
    type        = string 
    default     = "192.168.0.0/16"
}
variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["192.168.4.0/24", "192.168.5.0/24", "192.168.6.0/24"]
}
variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
