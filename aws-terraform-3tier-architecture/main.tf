terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "AWS-3Tier-Architecture"
      Owner       = "Someswararao Tarra"
    }
  }
}

# Module: VPC & Networking
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  environment        = var.environment
}

# Module: Security Groups
module "security" {
  source      = "./modules/security"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}

# Module: Compute & Auto Scaling
module "compute" {
  source             = "./modules/compute"
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnets
  private_subnets    = module.vpc.private_subnets
  alb_security_group = module.security.alb_security_group_id
  ec2_security_group = module.security.ec2_security_group_id
  instance_type      = var.instance_type
  environment        = var.environment
}

# Module: Multi-AZ Database
module "database" {
  source               = "./modules/database"
  db_subnets           = module.vpc.database_subnets
  db_security_group_id = module.security.db_security_group_id
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  environment          = var.environment
}
