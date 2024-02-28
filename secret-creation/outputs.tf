# secret id
output "learn_secret-secret_id" {
  description = "Secret Id: "
  value       = aws_secretsmanager_secret.learn_secret.id
}

# iam instance profile
output "iam-instance-profile-name" {
  description = "IAM instance profile name: "
  value       = aws_iam_instance_profile.sm_rw_test_profile.name
}