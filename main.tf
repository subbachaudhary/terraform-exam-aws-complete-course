module "vpc" {
  source  = "./modules/vpc"
  env     = var.env
  project = var.project
}
module "security_group" {
    source = "./modules/security_group"
    env    = var.env
    project = var.project
  
}