#######################################################################
# AWS VPC Security Groups. Env1.
#######################################################################
#----------------------------------------------------------------------
# Application.
#----------------------------------------------------------------------
module "app_sg" {
  source              = "terraform-aws-modules/security-group/aws"
  # version             = "x.x.x"

  name                = var.app_sg_default.name
  description         = var.app_sg_default.description
  vpc_id              = module.vpc.vpc_id

  ingress_cidr_blocks = [var.app_sg_default.ingress_cidr_block_default]

  ingress_rules       = var.app_sg_ingress_rules
  egress_rules        = var.app_sg_egress_rules
}

#----------------------------------------------------------------------
# ALB.
#----------------------------------------------------------------------
module "external_alb_sg" {
  source              = "terraform-aws-modules/security-group/aws"
  # version             = "x.x.x"

  name                = var.external_alb_sg_default.name
  description         = var.external_alb_sg_default.description
  vpc_id              = module.vpc.vpc_id

  ingress_cidr_blocks = [var.external_alb_sg_default.ingress_cidr_block_default]

  ingress_rules       = var.external_alb_sg_ingress_rules
  egress_rules        = var.external_alb_sg_egress_rules
}

#----------------------------------------------------------------------
# Bastion.
#----------------------------------------------------------------------
module "bastion_sg" {
  source              = "terraform-aws-modules/security-group/aws"
  # version             = "x.x.x"

  name                = var.bastion_default.name
  description         = var.bastion_default.description
  vpc_id              = module.vpc.vpc_id

  ingress_cidr_blocks = [var.bastion_default.ingress_cidr_block_default]

  ingress_rules       = var.bastion_ingress_rules
  egress_rules        = var.bastion_egress_rules
}
