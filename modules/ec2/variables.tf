variable "env" {}
variable "project_name" {}
variable "ami" {
    description = "defining ami id"
    type = string
    default = "ami-0889a44b331db0194"
}
variable "instance_type" {
    description = "defining instance type"
    type = string
    default = "t2.micro"
}
variable "security_group" {
    description = "defining security group for the ec2"
    type = set(string)
    default = [ "sg-038d40fd5f0f461bf" ]
}
variable "subnet_id" {
    description = "defining subnet id"
    type = string
    default = "subnet-0d3a871d603bc6f65"
  
}
variable "key_name" {
    description = "defining key name"
    type = string
    default = "terraform_ec2_key"
  
}


