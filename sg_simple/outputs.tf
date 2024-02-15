#for calling this module outside another module
output "id" {
  value = aws_security_group.learning_sg.id
  description = "The ID of the security group"
}
