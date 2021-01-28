#######################################################################
# AWS IAM Role. Env1.
#######################################################################
module "role" {
  source             = "cloudposse/iam-role/aws"
  # version            = "x.x.x"

  name      = var.role.name
  namespace = var.role.namespace
  stage     = var.role.stage


  enabled   = var.role.enabled

  policy_description = var.role.policy_description
  role_description   = var.role.role_description

  principals = {
    Service = ["autoscaling.amazonaws.com", "ec2.amazonaws.com" ]
  }

  policy_documents = [
    data.aws_iam_policy_document.resource_full_access.json,
    data.aws_iam_policy_document.base.json
  ]

  policy_document_count = var.role.policy_document_count
}

data "aws_iam_policy_document" "resource_full_access" {
  statement {
    sid       = "FullAccess"
    effect    = "Allow"
    resources = ["${module.s3_bucket.bucket_arn}/*"]

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:GetBucketLocation",
      "s3:AbortMultipartUpload"
    ]
  }
}

data "aws_iam_policy_document" "base" {
  statement {
    sid = "BaseAccess"

    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_instance_profile" "asg-env1" {
 name = "asg-env1"
 role = module.role.name
}