#######################################################################
# AWS VPC. Env1.
#######################################################################
module "vpc" {
  source                  = "terraform-aws-modules/vpc/aws"
  # version                 = "x.x.x"

  name                    = var.vpc_default.name
  cidr                    = var.vpc_default.cidr

  azs                     = var.vpc_azs
  private_subnets         = var.vpc_private_subnets
  public_subnets          = var.vpc_public_subnets

  enable_nat_gateway      = var.vpc_default.enable_nat_gateway
  enable_vpn_gateway      = var.vpc_default.enable_vpn_gateway
  one_nat_gateway_per_az  = var.vpc_default.one_nat_gateway_per_az

  enable_dns_hostnames    = var.vpc_default.enable_dns_hostnames
  enable_dns_support      = var.vpc_default.enable_dns_support
  map_public_ip_on_launch = var.vpc_default.map_public_ip_on_launch

  tags = {
    Environment           = var.vpc_default.tag1_value
  }
}
