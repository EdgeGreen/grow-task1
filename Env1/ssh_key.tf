######################################################################
# AWS EC2 SSH Keys. Env1.
######################################################################
module "ssh_key_pair" {
  source                = "git::https://github.com/cloudposse/terraform-aws-key-pair.git?ref=master"
  # version               = "x.x.x"  

  name                  = var.ssh_key_pair.name
  namespace             = var.ssh_key_pair.namespace
  stage                 = var.ssh_key_pair.stage

  generate_ssh_key      = var.ssh_key_pair.generate_ssh_key
  ssh_public_key_path   = var.ssh_key_pair.ssh_public_key_path
  private_key_extension = var.ssh_key_pair.private_key_extension
  public_key_extension  = var.ssh_key_pair.public_key_extension
  ssh_key_algorithm     = var.ssh_key_pair.ssh_key_algorithm
}