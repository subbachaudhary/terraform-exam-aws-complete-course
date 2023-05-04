terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      project     = var.project
      environment = var.env
    }
  }
}
terraform {
  backend "s3" {
    bucket = "terraform-backend-by-subba"
    key    = "dev/terraform.tfstate"
    #region = var.region

  }
}