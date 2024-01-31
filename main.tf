provider "aws" {
  profile = "default"
}

terraform {
  required_version = ">= 1.2.0"
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
  ami           = "ami-0014ce3e52359afbd"
  instance_type = "t3.micro"
  key_name = "learning_key_1"
  associate_public_ip_address = true

 #don't need this because in AMI I have volumes
 #root_block_device {
  #  volume_size           = 8
   # volume_type           = "standard"
    #delete_on_termination = true
  #}

  user_data = <<-EOF
  #!/bin/bash 
      apt-get update -y
      apt-get install ca-certificates curl gnupg -y
      install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update -y

    apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

    docker run hello-world

    apt-get install docker-compose-plugin -y
    docker compose version

  EOF

vpc_security_group_ids = [aws_security_group.learning_sg.id]

}
#added this string to create the pull request
#and another one string