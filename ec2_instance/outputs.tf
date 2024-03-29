output "ec2_ip" {
  description = "Instance public IP: "
  value       = ["${aws_instance.terraform_lerning.*.public_ip}"]
}

output "ec2_id" {
  description = "Instance Id: "
  value       = aws_instance.terraform_lerning.id
}