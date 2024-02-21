# security groups for aws_lb
variable "security_groups" {
  description = "The ids of sg"
  type        = list(string)
}

# ec2 instance id for aws_lb_target_group_attachment
variable "target_id" {
  description = "The id of ec2"
  type        = string
}