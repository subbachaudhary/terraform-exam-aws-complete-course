resource "aws_elastic_beanstalk_application" "eb" {
  name        = "${var.project_name}-${var.env}"
  description = "This elastic beanstalk application is used for ${var.env} project of  ${var.project_name}"
}

resource "aws_elastic_beanstalk_environment" "go_app" {
  name                = "${var.project_name}-${var.env}-go"
  application         = aws_elastic_beanstalk_application.eb.name
  solution_stack_name = var.api_solution_stack_name

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VpcId"
    value     = var.vpc_id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.private_subnet_cidr_blocks)
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = var.eb_ec2_sg
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"

  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerIsShared"
    value     = "True"
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SharedLoadBalancer"
    value     = var.shared_alb_arn
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "Rules"
    value     = "https"
  }
  setting {
    namespace = "aws:elbv2:listenerrule:https"
    name      = "HostHeaders"
    value     = var.api_domain
  }
  setting {
    namespace = "aws:elbv2:listenerrule:https"
    name      = "Priority"
    value     = 4
  }

  setting {
    namespace = "aws:elbv2:listener:80"
    name      = "Rules"
    value     = "default, new"
  }

  setting {
    namespace = "aws:elbv2:listenerrule:new"
    name      = "HostHeaders"
    value     = var.api_domain
  }
  setting {
    namespace = "aws:elbv2:listenerrule:new"
    name      = "Priority"
    value     = 2
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "InstanceRefreshEnabled"
    value     = true
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = var.shared_alb_sg
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = "/health-check"
  }
}