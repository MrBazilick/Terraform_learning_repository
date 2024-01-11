output "ec2_global_ips" {
    description = "Instance publick IP: "
  value = ["${aws_instance.terraform_lerning.*.public_ip}"]
}
