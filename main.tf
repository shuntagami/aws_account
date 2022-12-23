locals {
  users = [
    {
      name : "admin",
      groups : [aws_iam_group.admin.name, aws_iam_group.developers.name]
    },
    {
      name : "shuntagami",
      groups : [aws_iam_group.developers.name]
    }
  ]
}

/*====
Account alias
======*/
resource "aws_iam_account_alias" "alias" {
  account_alias = "shuntagami"
}

/*====
IAM User group
======*/
resource "aws_iam_group" "developers" {
  name = "developers"
}

resource "aws_iam_group" "admin" {
  name = "admin"
}

resource "aws_iam_group_policy_attachment" "user_group_policy" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "admin_group_policy" {
  group      = aws_iam_group.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

/*====
IAM User
======*/
resource "aws_iam_user" "user" {
  for_each = { for user in local.users : user.name => user }
  name     = each.value.name
}

resource "aws_iam_user_group_membership" "user_group_membership" {
  for_each = { for user in local.users : user.name => user }
  user     = each.value.name
  groups   = each.value.groups
  depends_on = [
    aws_iam_user.user
  ]
}
