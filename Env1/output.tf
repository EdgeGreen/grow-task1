#######################################################################
# AWS Outputs. Env1.
#######################################################################
output "dev_alb_dns_name" {
  value = module.alb.alb_dns_name
}