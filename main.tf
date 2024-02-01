data "aws_caller_identity" "current" {
  # for AWS account name output
}

# Security group
resource "aws_security_group" "learning_sg" {
  name        = "learning_sg"
  description = "Allow inbound HTTPS, HTTP and SSH traffic"

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow"
  }
}

#This command need only if you don't have private key on AWS, for this task no need 
#to create new key, just to use existing, and for this reason I can just use the 
#key name in recource "aws_instance"

#public ssh key
#resource "aws_key_pair" "learning" {
#  key_name   = "learning_key_1"
#  public_key = ""
#}

#Instance launch
resource "aws_instance" "terraform_lerning" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_pair
  associate_public_ip_address = true
  user_data = file("script.sh")
  vpc_security_group_ids = [aws_security_group.learning_sg.id]

#if I need to write userdata inside tf recource. leave this for example) 
# user_data = <<-EOF
#EOF
}
#added this string to create the pull request