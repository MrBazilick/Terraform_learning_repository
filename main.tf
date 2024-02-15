data "aws_caller_identity" "current" {
  # for AWS account name output
}

#This command need only if you don't have private key on AWS, for this task no need 
#to create new key, just to use existing, and for this reason I can just use the 
#key name in recource "aws_instance"

#public ssh key
#resource "aws_key_pair" "learning" {
#  key_name   = "learning_key_1"
#  public_key = ""
#}

#Instance launch with module
module "ec2_instance" {
  source  = "./ec2_instance"
}

#saved here secret creation configuration
#secret creation:

#data "aws_secretsmanager_random_password" "test1" {
#  password_length            = 50
#  require_each_included_type = true
#}

#resource "aws_secretsmanager_secret" "learn_secret" {
#  description = "Practice with aws secret manager"
#  name        = "learn_secret2"
#}

#resource "aws_secretsmanager_secret_version" "learn_secret" {
#  secret_id     = aws_secretsmanager_secret.learn_secret.id
#  secret_string = data.aws_secretsmanager_random_password.test1.id
#}