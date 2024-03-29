data "aws_caller_identity" "current" {
  # for AWS account name output
}

# This command need only if you don't have private key on AWS, for this task no need 
# to create new key, just to use existing, and for this reason I can just use the 
# key name in recource "aws_instance"
#
# public ssh key
#resource "aws_key_pair" "learning" {
#  key_name   = "learning_key_1"
#  public_key = ""
#}

# SG module calling
module "sg_simple" {
  source = "./sg_simple"
}

# Instance launch with module
module "ec2_instance" {
  source  = "./ec2_instance"

  vpc_security_group_ids = [module.sg_simple.learning_sg_id]
}

# lb launch with module
module "aws-app-lb" {
  source  = "./aws-app-lb"

  security_groups = [module.sg_simple.app_elb_sg_id]
  target_id       = module.ec2_instance.ec2_id
}