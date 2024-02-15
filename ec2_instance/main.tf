#SG module calling
module "sg_simple" {
  source = "../sg_simple"
}

#Instance launch
resource "aws_instance" "terraform_lerning" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  associate_public_ip_address = true
  user_data                   = file("${path.module}/script.sh")
  vpc_security_group_ids      = [module.sg_simple.id]

 tags = {
    Terraform   = "true"
    Environment = "test"
  }
#if I need to write userdata inside tf recource. leave this for example) 
# user_data = <<-EOF
#EOF
}