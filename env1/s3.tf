#######################################################################
# AWS S3 and IAM Role. Env1.
#######################################################################
module "s3_bucket" {
  source                   = "cloudposse/s3-bucket/aws"
  # version                  = "x.x.x"

  name                     = var.s3_bucket.name
  stage                    = var.s3_bucket.namespace
  namespace                = var.s3_bucket.stage

  enabled                  = var.s3_bucket.enabled

  acl                      = var.s3_bucket.acl
  user_enabled             = var.s3_bucket.user_enabled
  versioning_enabled       = var.s3_bucket.versioning_enabled
  force_destroy            = var.s3_bucket.force_destroy
}