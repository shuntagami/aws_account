/*====
Account alias
======*/
resource "aws_iam_account_alias" "alias" {
  account_alias = "shuntagami"
}

/*====
IAM User group
======*/
data "aws_caller_identity" "current" {}

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

module "enforce_mfa" {
  source = "terraform-module/enforce-mfa/aws"

  policy_name                     = "managed-mfa-enforce"
  account_id                      = data.aws_caller_identity.current.id
  groups                          = [aws_iam_group.developers.name, aws_iam_group.admin.name]
  manage_own_signing_certificates = true
  manage_own_ssh_public_keys      = true
  manage_own_git_credentials      = true
}

/*====
IAM User
======*/
module "iam_user" {
  source = "./modules/iam_user"
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
