/*====
IAM User
======*/
resource "aws_iam_user" "user" {
  for_each = { for user in var.users : user.name => user }
  name     = each.value.name
  tags     = {}
}

resource "aws_iam_user_group_membership" "user_group_membership" {
  for_each = { for user in var.users : user.name => user }
  user     = each.value.name
  groups   = each.value.groups
  depends_on = [
    aws_iam_user.user
  ]
}

resource "aws_iam_user_login_profile" "example" {
  for_each                = { for user in var.users : user.name => user }
  user                    = each.value.name
  password_length         = 16
  password_reset_required = true
  depends_on = [
    aws_iam_user.user
  ]
  lifecycle {
    ignore_changes = [password_reset_required]
  }
}
