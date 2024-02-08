#t3.micro instance block

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "ami" {
  description = "The ami of instance"
  type        = string
  default     = "ami-0014ce3e52359afbd" #Amazon AMI
}

variable "key_pair" {
  description = "The name of key-pair"
  type        = string
  default     = "learning_key_1"
}