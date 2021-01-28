#----------------------------------------------------------------------
# AWS Region - "US East (N. Virginia)". Env1.
#----------------------------------------------------------------------
variable "region" {
  type                                        = string
  default                                     = "us-east-1"
}

#----------------------------------------------------------------------
# AWS VPC. Env1.
#----------------------------------------------------------------------
variable "vpc_default" {
  description = "Name and cidr of the VPC"
  type                                        = map
  default = {
    "name"                                    = "env1"
    "cidr"                                    = "10.0.0.0/16"
    
    "enable_nat_gateway"                      = "true"
    "enable_vpn_gateway"                      = "false"
    "one_nat_gateway_per_az"                  = "false"

    "enable_dns_hostnames"                    = "true"
    "enable_dns_support"                      = "true"
    "map_public_ip_on_launch"                 = "false"

    "tag1_value"                              = "env1"
  }
}

variable "vpc_azs" {
  description = "A list of azs inside the VPC"
  type                                        = list(string)
  default                                     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type                                        = list(string)
  default                                     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type                                        = list(string)
  default                                     = ["10.0.1.0/24", "10.0.2.0/24"]
}

#----------------------------------------------------------------------
# AWS VPC Security Groups. Application. Env1.
#----------------------------------------------------------------------
variable "app_sg_default" {
  description = "Default parameters for security group 'app'" 
  type                                        = map
  default = {
    "name"                                    = "app-sg-env1"
    "ingress_cidr_block_default"              = "10.0.0.0/16"
    "description"                             = "443-80-22-icmp"
  }
}

variable "app_sg_ingress_rules" {
  description = "A list Ingress-rules for 'app-sg-env1'"
  type                                        = list(string)
  default                                     = ["ssh-tcp", "all-icmp","https-443-tcp", "http-80-tcp"]
}

variable "app_sg_egress_rules" {
  description = "A list Egress-rules for 'app-sg-env1'"
  type                                        = list(string)
  default                                     = ["all-all"]
}

#----------------------------------------------------------------------
# AWS VPC Security Groups. ALB. Env1.
#----------------------------------------------------------------------
variable "external_alb_sg_default" {
  description = "Default parameters for security group 'external-alb'"
  type                                        = map
  default = {
    "name"                                    = "external-alb-sg-dev"
    "ingress_cidr_block_default"              = "0.0.0.0/0"
    "description"                             = "443-80"
  }
}

variable "external_alb_sg_ingress_rules" {
  description                                 = "A list Ingress-rules for 'external-alb'"
  type                                        = list(string)
  default                                     = ["https-443-tcp", "http-80-tcp"]
}

variable "external_alb_sg_egress_rules" {
  description                                 = "A list Egress-rules for 'external-alb'"
  type                                        = list(string)
  default                                     = ["all-all"]
}

#----------------------------------------------------------------------
# AWS VPC Security Groups. Bastion. Env1.
#----------------------------------------------------------------------
variable "bastion_default" {
  description = "Default parameters for security group 'bastion'" 
  type                                        = map
  default = {
    "name"                                    = "bastion-dev"
    "ingress_cidr_block_default"              = "0.0.0.0/0"
    "description"                             = "22"
  }
}

variable "bastion_ingress_rules" {
  description = "A list Ingress-rules for 'bastion'"
  type                                        = list(string)
  default                                     = ["ssh-tcp", "all-icmp"]
}

variable "bastion_egress_rules" {
  description = "A list Egress-rules for 'bastion'"
  type                                        = list(string)
  default                                     = ["all-all"]
}
#----------------------------------------------------------------------
# AWS VPC External ALB. Env1.
#----------------------------------------------------------------------
variable "external_alb" {
  description = "Parameters for External ALB"  
  type                                        = map
  default = {
    "namespace"                               = "eg"
    "stage"                                   = "dev"
    "attributes"                              = "1"
    "delimiter"                               = "-"

    "name"                                    = "external-alb"  
    "internal"                                = "false"

    "http_enabled"                            = "true"
    "http_redirect"                           = "false"
    "http2_enabled"                           = "false"

    "access_logs_enabled"                     = "false"
    "alb_access_logs_s3_bucket_force_destroy" = "false"
    
    "cross_zone_load_balancing_enabled"       = "false"
    "deletion_protection_enabled"             = "false"

    "idle_timeout"                            = "60"
    "ip_address_type"                         = "ipv4"
    
    "deregistration_delay"                    = "15"
    "health_check_path"                       = "/"
    "health_check_timeout"                    = "10"
    "health_check_healthy_threshold"          = "2"
    "health_check_unhealthy_threshold"        = "2"
    "health_check_interval"                   = "15"
    "health_check_matcher"                    = "200-399"
    "target_group_port"                       = "80"
    "target_group_target_type"                = "instance"
    "target_group_name"                       = "external-alb-tg-dev"
    "target_group_protocol"                   = "HTTP"
  }
}

variable "external_alb_tags" {
  description = "Parameters for External ALB"  
  type                                        = map(string)
  default = {
     "tags"                                   = "env1"
  }
}

#----------------------------------------------------------------------
# AWS Auto Scaling Group. Application. Env1
#----------------------------------------------------------------------
variable "asg-app" {
  description = "Parameters for Auto Scaling Group"
  type                                       = map
  default = {
    "name"                                   = "app-asg"
    "namespace"                              = "eg"
    "stage"                                  = "env1"

    "image_id"                               = "ami-0885b1f6bd170450c" #Ubuntu-20.04
    "instance_type"                          = "t2.micro"

    "health_check_type"                      = "ELB"
    "min_size"                               = "2"
    "max_size"                               = "4"
    "wait_for_capacity_timeout"              = "20m"
    "associate_public_ip_address"            = "true"
    
    "autoscaling_policies_enabled"           = "true"
    "cpu_utilization_high_threshold_percent" = "90"
    "cpu_utilization_low_threshold_percent"  = "20"

    "tag1"                                   = "app-asg-env1."

  }
}

#----------------------------------------------------------------------
# AWS Auto Scaling Group. Bastion. Env1
#----------------------------------------------------------------------
variable "asg-bastion" {
  description = "Parameters for Auto Scaling Group"
  type                                       = map
  default = {
    "name"                                   = "bastion-asg"
    "namespace"                              = "eg"
    "stage"                                  = "env1"

    "image_id"                               = "ami-0885b1f6bd170450c" #Ubuntu-20.04
    "instance_type"                          = "t2.micro"

    "associate_public_ip_address"            = "true"

    "health_check_type"                      = "ELB"
    "min_size"                               = "1"
    "max_size"                               = "1"
    "wait_for_capacity_timeout"              = "20m"
    "associate_public_ip_address"            = "true"
    
    "autoscaling_policies_enabled"           = "true"
    "cpu_utilization_high_threshold_percent" = "90"
    "cpu_utilization_low_threshold_percent"  = "20"

    "tag1"                                   = "bastion-asg-env1."

  }
}

#----------------------------------------------------------------------
# AWS EC2 SSH Keys. Env1.
#----------------------------------------------------------------------
variable "ssh_key_pair" {
  description = "Parameters for EC2 SSH Keys"
  type                                     = map
  default = {
    "name"                                 = "app"
    "namespace"                            = "eg"
    "stage"                                = "env1"

    "generate_ssh_key"                     = "true"
    "ssh_public_key_path"                  = "./secrets"
    "private_key_extension"                = ".pem"
    "public_key_extension"                 = ".pub"
    "ssh_key_algorithm"                    = "RSA"
  }
}

#----------------------------------------------------------------------
# AWS S3. Env1.
#----------------------------------------------------------------------
variable "s3_bucket" {
  description = "Parameters for S3 Bucket"
  type                                     = map
  default = {
    "name"                                 = "app"
    "namespace"                            = "eg"
    "stage"                                = "env1"

    "enabled"                              = "true"
    "acl"                                  = "private"
    "user_enabled"                         = "false"
    "versioning_enabled"                   = "true"
    "force_destroy"                        = "true"

 } 
}

#----------------------------------------------------------------------
# AWS IAM Role. Env1.
#----------------------------------------------------------------------
variable "role" {
  description = "Parameters for IAM Role"
  type                                     = map
  default = {
    "name"                                 = "app"
    "namespace"                            = "eg"
    "stage"                                = "env1"

    "enabled"                              = "true"
    "policy_description"                   = "Allow S3 FullAccess"
    "role_description"                     = "IAM role with permissions to perform actions on S3 resources"
    "policy_document_count"                = "2"

    "force_destroy"                        = "true"
 } 
}