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
