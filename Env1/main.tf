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
  region = var.region
}
