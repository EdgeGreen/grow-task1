#######################################################################
# VPC. Env1.
#######################################################################
module "alb" {
    source                                  = "cloudposse/alb/aws"
    # version                                 = "x.x.x"

    namespace                               = var.external_alb.namespace
    stage                                   = var.external_alb.stage
    attributes                              = [var.external_alb.attributes]
    delimiter                               = var.external_alb.delimiter
    
    name                                    = var.external_alb.name
    vpc_id                                  = module.vpc.vpc_id
    security_group_ids                      = [module.external_alb_sg.this_security_group_id]
    subnet_ids                              = module.vpc.public_subnets
    internal                                = var.external_alb.internal

    http_enabled                            = var.external_alb.http_enabled
    http_redirect                           = var.external_alb.http_redirect
    http2_enabled                           = var.external_alb.http2_enabled

    access_logs_enabled                     = var.external_alb.access_logs_enabled
    alb_access_logs_s3_bucket_force_destroy = var.external_alb.alb_access_logs_s3_bucket_force_destroy

    cross_zone_load_balancing_enabled       = var.external_alb.cross_zone_load_balancing_enabled
    deletion_protection_enabled             = var.external_alb.deletion_protection_enabled
  
    idle_timeout                            = var.external_alb.idle_timeout
    ip_address_type                         = var.external_alb.ip_address_type

    deregistration_delay                    = var.external_alb.deregistration_delay
    health_check_path                       = var.external_alb.health_check_path
    health_check_timeout                    = var.external_alb.health_check_timeout
    health_check_healthy_threshold          = var.external_alb.health_check_healthy_threshold
    health_check_unhealthy_threshold        = var.external_alb.health_check_unhealthy_threshold
    health_check_interval                   = var.external_alb.health_check_interval
    health_check_matcher                    = var.external_alb.health_check_matcher
    target_group_port                       = var.external_alb.target_group_port
    target_group_target_type                = var.external_alb.target_group_target_type
    target_group_name                       = var.external_alb.target_group_name
    target_group_protocol                   = var.external_alb.target_group_protocol

    tags                                    = var.external_alb_tags
}