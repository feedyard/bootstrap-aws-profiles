provider "aws" {
  alias = "profile"
  region = "${var.profile_region}"
  access_key="${var.profile_access_key}"
  secret_key="${var.profile_secret_key}"
}

# nonprod accounts
resource "aws_iam_group" "assume_nonprod_role_group" {
  provider = "aws.profile"
  name = "AssumeNonprodRoleGroup"
}

resource "aws_iam_group_policy" "assume_nonprod_role_group_policy" {
  provider = "aws.profile"
  name = "AssumeRolePolicy"
  group = "${aws_iam_group.assume_nonprod_role_group.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::750464328775:role/TerraformRole"
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::151701496001:role/TerraformRole"
    }
  ]
}
EOF
}


# prod accounts
resource "aws_iam_group" "assume_prod_role_group" {
  provider = "aws.profile"
  name = "AssumeProdRoleGroup"
}

resource "aws_iam_group_policy" "assume_prod_role_group_policy" {
  provider = "aws.profile"
  name = "AssumeRolePolicy"
  group = "${aws_iam_group.assume_prod_role_group.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::538257557236:role/TerraformRole"
    }
  ]
}
EOF
}