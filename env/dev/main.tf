terraform {
  backend "s3" {}
}

module "vpc" {
  source = "../../modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones # Changed to match module var
  tags                 = var.tags
}

module "security_groups" {
  source = "../../modules/security-group"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
  vpc_cidr     = var.vpc_cidr
}

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment
  github_repo  = var.github_repo

  tags = var.tags
}

module "ssm_endpoints" {
  source = "../../modules/ssm"

  project_name       = var.project_name
  environment        = var.environment
  aws_region         = var.aws_region
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  ssm_endpoint_sg_id = module.security_groups.ssm_endpoint_security_group_id # Matches output name
}

module "launch_template" {
  source = "../../modules/ec2-launch-template"

  project_name          = var.project_name
  environment           = var.environment
  instance_type         = var.instance_type
  instance_profile_name = module.iam.ec2_instance_profile_name
  security_group_id     = module.security_groups.ec2_security_group_id # Matches output name
  root_volume_size      = var.root_volume_size

}

module "alb" {
  source = "../../modules/alb"

  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security_groups.alb_security_group_id # Matches output name
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  project_name       = var.project_name
  environment        = var.environment
  private_subnet_ids = module.vpc.private_subnet_ids
  launch_template_id = module.launch_template.launch_template_id
  target_group_arn   = module.alb.target_group_arn
}

module "monitoring" {
  source = "../../modules/monitoring"

  project_name      = var.project_name
  environment       = var.environment
  asg_name          = module.autoscaling.asg_name
  alert_email       = var.alert_email
  slack_webhook_url = var.slack_webhook_url
}

module "backup" {
  source = "../../modules/backup"

  project_name = var.project_name
  environment  = var.environment

}