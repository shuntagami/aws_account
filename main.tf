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
resource "aws_iam_user" "admin" {
  name = "admin"
}

resource "aws_iam_user" "shuntagami" {
  name = "shuntagami"
}

resource "aws_iam_group_membership" "admin" {
  name = "developer-group-membership"

  users = [
    aws_iam_user.admin.name,
  ]

  group = aws_iam_group.admin.name
}

resource "aws_iam_group_membership" "developer" {
  name = "developer-group-membership"

  users = [
    aws_iam_user.admin.name,
    aws_iam_user.shuntagami.name,
  ]

  group = aws_iam_group.developers.name
}
