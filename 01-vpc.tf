module "vpc" {
  source = "./modules/vpc"

  environment     = var.environment
  vpc_cidr        = var.vpc_cidr
  subnets         = var.subnets
  route_tables    = var.route_tables
  security_groups = var.security_groups
}