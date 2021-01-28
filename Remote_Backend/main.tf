#######################################################################
# AWS Region - "US East (N. Virginia)". Env1.
#######################################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.25.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#############################################################################
# Amazon S3 Bucket.
#############################################################################
resource "aws_s3_bucket" "terraform_state" {
    bucket = "grow-project-terraform-state"

    # lifecycle {
    #     prevent_destroy = true
    #    }

    versioning {
        enabled = true
    }
       server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
            }
        }
    }
}

#############################################################################
# Amazon DynamoDB. Grow-project.
#############################################################################
resource "aws_dynamodb_table" "terraform_locks" {
    name = "grow-project-state-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    
    attribute {
        name = "LockID"
        type = "S"
    }
}