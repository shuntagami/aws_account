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
