output "ec2_global_ips" {
  description = "Instance publick IP: "
  value       = ["${module.ec2_instance.*.public_ip}"]
}