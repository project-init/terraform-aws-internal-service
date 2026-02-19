output "service_name" {
  value       = var.service_name
  description = "The name of the service."
}

output "service_iam_role_arn" {
  value       = aws_iam_role.service.arn
  description = "The ARN of the IAM role for the internal service"
}

output "service_iam_role_name" {
  value       = aws_iam_role.service.name
  description = "The name of the IAM role for the internal service"
}

output "security_group_id" {
  value       = aws_security_group.service.id
  description = "The ID of the security group for the internal service"
}
