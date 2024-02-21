#for calling this module outside another module
output "learning_sg_id" {
  value = aws_security_group.learning_sg.id
  description = "The ID of the security group for ec2"
}

output "app_elb_sg_id" {
  value = aws_security_group.app_elb_sg.id
  description = "The ID of the security group for the lb"
}