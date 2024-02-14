#Instance launch
resource "aws_instance" "terraform_lerning" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  associate_public_ip_address = true
  user_data                   = file(var.user_data)
  vpc_security_group_ids      = [aws_security_group.learning_sg.id]

#if I need to write userdata inside tf recource. leave this for example) 
# user_data = <<-EOF
#EOF
}
