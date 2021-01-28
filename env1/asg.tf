#######################################################################
# AWS Auto Scaling Group. Env1.
#######################################################################
#----------------------------------------------------------------------
# Application.
#----------------------------------------------------------------------
module "autoscale_group_app" {
  source                                 = "cloudposse/ec2-autoscale-group/aws"
  # version                                = "x.x.x"

  name                                   = var.asg-app.name
  namespace                              = var.asg-app.namespace
  stage                                  = var.asg-app.stage


  image_id                               = var.asg-app.image_id
  instance_type                          = var.asg-app.instance_type

  security_group_ids                     = [module.app_sg.this_security_group_id]
  subnet_ids                             = module.vpc.vpc_private_subnets
  target_group_arns                      = [module.alb.default_target_group_arn]
  iam_instance_profile_name              = aws_iam_instance_profile.asg-env1.name
  associate_public_ip_address            = var.asg-app.associate_public_ip_address

  health_check_type                      = var.asg-app.health_check_type
  min_size                               = var.asg-app.min_size
  max_size                               = var.asg-app.max_size
  wait_for_capacity_timeout              = var.asg-app.wait_for_capacity_timeout

  user_data_base64                       = base64encode(data.template_file.init.rendered)
  key_name                               = module.ssh_key_pair.key_name #aws_key_pair.key_pair.id

  tags = {
    Name                                 = var.asg-app.tag1
  }

  # Auto-scaling policies and CloudWatch metric alarms
  autoscaling_policies_enabled           = var.asg-app.autoscaling_policies_enabled
  cpu_utilization_high_threshold_percent = var.asg-app.cpu_utilization_high_threshold_percent
  cpu_utilization_low_threshold_percent  = var.asg-app.cpu_utilization_low_threshold_percent
}

data "template_file" "init" {
  template = file("user_data/user_data.sh.tpl")

  vars = {
    s3_bucket_address                    = module.s3_bucket.bucket_id
  }
}

#----------------------------------------------------------------------
# Bastion.
#----------------------------------------------------------------------
module "autoscale_group_bastion" {
  source                                 = "cloudposse/ec2-autoscale-group/aws"
  # version                                = "x.x.x"

  name                                   = var.asg-bastion.name
  namespace                              = var.asg-bastion.namespace
  stage                                  = var.asg-bastion.stage


  image_id                               = var.asg-bastion.image_id
  instance_type                          = var.asg-bastion.instance_type

  security_group_ids                     = [module.bastion_sg.this_security_group_id]
  subnet_ids                             = module.vpc.public_subnets
  # target_group_arns                      = [module.alb.default_target_group_arn]
  # iam_instance_profile_name              = aws_iam_instance_profile.asg-env1.name
  associate_public_ip_address            = var.asg-bastion.associate_public_ip_address

  health_check_type                      = var.asg-bastion.health_check_type
  min_size                               = var.asg-bastion.min_size
  max_size                               = var.asg-bastion.max_size
  wait_for_capacity_timeout              = var.asg-bastion.wait_for_capacity_timeout

  # user_data_base64                       = base64encode(data.template_file.init.rendered)
  key_name                               = module.ssh_key_pair.key_name #aws_key_pair.key_pair.id

  tags = {
    Name                                 = var.asg-bastion.tag1
  }

  # Auto-scaling policies and CloudWatch metric alarms
  autoscaling_policies_enabled           = var.asg-bastion.autoscaling_policies_enabled
  cpu_utilization_high_threshold_percent = var.asg-bastion.cpu_utilization_high_threshold_percent
  cpu_utilization_low_threshold_percent  = var.asg-bastion.cpu_utilization_low_threshold_percent
}