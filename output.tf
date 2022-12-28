output "user_name" {
  description = "user name"
  value       = module.iam_user.user_name
}

output "user_password" {
  description = "user password"
  value       = module.iam_user.user_password
}
