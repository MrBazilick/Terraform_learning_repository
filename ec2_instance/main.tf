/*# Secret creation module calling (temporary commented)
module "secret-creation" {
  source = "../secret-creation"
}*/

# Instance launch
resource "aws_instance" "terraform_lerning" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  associate_public_ip_address = true
  # user data without secret creation 
  user_data                   = file("${path.module}/script1.sh")
  /*# user data that includs secret creation (temporary commented) 
  user_data = templatefile("${path.module}/script.sh.tpl", {
    secret_id = module.secret-creation.learn_secret-secret_id # needed for secret creation
  })*/
  vpc_security_group_ids      = var.vpc_security_group_ids
# iam_instance_profile        = module.secret-creation.iam-instance-profile-name # needed for secret creation (temporary commented)

 tags = {
    Terraform   = "true"
    Environment = "test"
  }
# if I need to write userdata inside tf recource. leave this for example) 
# user_data = <<-EOF
#EOF
}