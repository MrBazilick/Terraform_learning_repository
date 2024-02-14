output "account_id" {
  description = "Account ID: "
  value       = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  description = "ARN(Amazon Resource Nam): "
  value       = data.aws_caller_identity.current.arn
}

output "caller_user" {
  description = "Unique identifier of the calling entity: "
  value       = data.aws_caller_identity.current.user_id
}