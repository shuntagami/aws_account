output "user_name" {
  description = "user name"
  value = toset([
    for user in aws_iam_user.user : user.name
  ])
}

output "user_password" {
  description = "user name"
  value = toset([
    for profile in aws_iam_user_login_profile.example : profile.encrypted_password
  ])
}
