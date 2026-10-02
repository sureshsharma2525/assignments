#Provuder base configuration for the account
provider "aws" {
  alias  = "account_b"
  region = "us-east-1"
}

resource "aws_iam_user" "account_1" {
  provider = aws.account_b
  name     = "account name"
}

resource "aws_iam_user" "account_2" {
  provider = aws.account_b
  name     = "account name"
}

resource "aws_iam_user" "account_3" {
  provider = aws.account_b
  name     = "account name"
}

resource "aws_iam_user" "account_4" {
  provider = aws.account_b
  name     = "account name"
}

resource "aws_iam_group" "group1" {
  provider = aws.account_b
  name     = "group1"
}
####################################
resource "aws_iam_user_group_membership" "group1_members" {
  provider = aws.account_b
  user = [
    aws_iam_user.engine.name,
    aws_iam_user.ci.name
  ]
  groups = [
    aws_iam_group.group1.name
  ]
}

data "aws_iam_policy_document" "roleA_policy" {
  statement {
    effect = "Allow"

    not_actions = [
      "iam:*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "roleA" {
  provider = aws.account_b
  name = "roleA"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          AWS = "arn:aws:iam::000000000000:root"   (Type the extact ARN of root)
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "roleA_policy" {
  provider = aws.account_b
  name = "roleA-admin-except-iam"
  role = aws_iam_role.roleA.id
  policy = data.aws_iam_policy_document.roleA_policy.json
}