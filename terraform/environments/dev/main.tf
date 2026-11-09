locals {
  name = "${var.project_name}-${var.environment}"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "networking" {
  source = "../../modules/networking"

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
}

module "security" {
  source = "../../modules/security"

  name              = local.name
  vpc_id            = module.networking.vpc_id
  alb_ingress_cidrs = var.alb_ingress_cidrs
  tags              = local.tags
}

module "iam" {
  source = "../../modules/iam"

  name = local.name
  tags = local.tags
}

module "alb" {
  source = "../../modules/alb"

  name                       = local.name
  vpc_id                     = module.networking.vpc_id
  subnet_ids                 = module.networking.subnet_ids
  security_group_id          = module.security.alb_security_group_id
  enable_deletion_protection = var.enable_deletion_protection
  tags                       = local.tags
}

module "compute" {
  source = "../../modules/compute"

  name                  = local.name
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  key_name              = var.key_name
  volume_size           = var.volume_size
  security_group_id     = module.security.instance_security_group_id
  instance_profile_name = module.iam.instance_profile_name
  subnet_ids            = module.networking.subnet_ids
  target_group_arn      = module.alb.target_group_arn
  min_size              = var.asg_min_size
  desired_capacity      = var.asg_desired_capacity
  max_size              = var.asg_max_size
  tags                  = local.tags
}

module "monitoring" {
  source = "../../modules/monitoring"

  name                  = local.name
  alert_email           = var.alert_email
  asg_name              = module.compute.asg_name
  scale_up_policy_arn   = module.compute.scale_up_policy_arn
  scale_down_policy_arn = module.compute.scale_down_policy_arn
  cpu_high_threshold    = var.cpu_high_threshold
  tags                  = local.tags
}
