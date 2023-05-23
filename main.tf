# module "vpc" {
#   source                     = "./modules/vpc"
#   vpc_cidr                   = var.vpc_cidr
#   env                        = var.env
#   project_name               = var.project_name
#   public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
#   private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
#   availability_zones         = var.availability_zones
#   region                     = var.region
# }

# module "security_group" {
#   source       = "./modules/security_group"
#   env          = var.env
#   project_name = var.project_name
#   vpc_id       = module.vpc.vpc_id
#   depends_on = [
#     module.vpc
#   ]
# }

# module "load_balancer" {
#   source                    = "./modules/loadbalancer"
#   env                       = var.env
#   project_name              = var.project_name
#   public_subnet_cidr_blocks = module.vpc.public_subnet_list
#   vpc_id                    = module.vpc.vpc_id
#   alb_sg                    = module.security_group.alb_sg
#   certificate_arn           = module.certificates.certificate_arn

#   depends_on = [
#     module.security_group,
#     module.vpc,
#     module.certificates
#   ]
# }

# module "elasticbeanstalk" {
#   source                     = "./modules/elastic-beanstalk"
#   env                        = var.env
#   project_name               = var.project_name
#   private_subnet_cidr_blocks = module.vpc.private_subnet_list
#   vpc_id                     = module.vpc.vpc_id
#   shared_alb_arn             = module.load_balancer.shared_alb_arn
#   shared_alb_sg              = module.security_group.alb_sg
#   eb_ec2_sg                  = module.security_group.eb_ec2_sg
#   api_domain                 = var.api_domain
#   api_solution_stack_name    = var.api_solution_stack_name

#   depends_on = [
#     module.load_balancer,
#     module.vpc,
#     module.security_group,
#     module.certificates
#   ]
# }

# module "certificates" {
#   source                                 = "./modules/certificates"
#   env                                    = var.env
#   project_name                           = var.project_name
#   domain_name                            = var.domain_name
#   zone_name                              = var.zone_name
#   api_subject_alternative_names          = var.api_subject_alternative_names
#   #front_subject_alternative_domain_names = var.frontend_subject_alternative_names

# }

# module "route53" {
#   source              = "./modules/route53"
#   env                 = var.env
#   project_name        = var.project_name
#   route53_zone_id     = module.certificates.route53_zone_id
#   route53_name        = module.certificates.route53_name
#   shared_alb_zone_id  = module.load_balancer.shared_alb_zone_id
#   shared_alb_dns_name = module.load_balancer.shared_alb_dns_name
#   # domains_list        = var.subject_alternative_names
#   api_domain   = var.api_domain
#   #bucket_names = var.bucket_names
#   depends_on = [
#     module.load_balancer,
#     module.vpc,
#     module.security_group,
#     module.certificates
#   ]
# }

# module "database" {
#   source                 = "./modules/rds"
#   env                    = var.env
#   project_name           = var.project_name
#   aws_db_subnet_group_id = module.vpc.rds_subnet_group_id
#   rds_sg_id              = module.security_group.rds_sg_id
#   depends_on = [
#     module.vpc
#   ]
# }

# module "cognito" {
#   source       = "./modules/cognito"
#   env          = var.env
#   project_name = var.project_name
# }

# module "s3" {
#   source       = "./modules/s3"
#   env          = var.env
#   project_name = var.project_name
#   bucket_names = var.bucket_names
#   domain_name  = var.domain_name
#   depends_on = [
#     module.elasticbeanstalk
#   ]
# }

# module "cloudfront" {
#   source                  = "./modules/cloudfront"
#   env                     = var.env
#   project_name            = var.project_name
#   bucket_names            = var.bucket_names
#   domain_name             = var.domain_name
#   admin_bucket_public_url = module.s3.admin_bucket_public_url
#   user_bucket_public_url  = module.s3.user_bucket_public_url
#   bucket_public_urls      = module.s3.bucket_public_url
#   bucket_info             = module.s3.bucket_info
#   front_certificate_arn   = module.front_certificates.front_certificate_arn
#   depends_on = [
#     module.certificates
#   ]
# }

# module "front_certificates" {
#   source = "./modules/front_certificate"
#   # providers = {
#   #   aws = aws.east
#   # }
#   env                                    = var.env
#   project_name                           = var.project_name
#   domain_name                            = var.domain_name
#   zone_name                              = var.zone_name
#   front_subject_alternative_domain_names = var.frontend_subject_alternative_names
# }
module "lambda" {
  source = "./modules/lambda"
}
# module "ec2" {
#   source       = "./modules/ec2"
#   project_name = var.project_name
#   env          = var.env
# }
# module "iam" {
#   source = "./modules/iam"

# }