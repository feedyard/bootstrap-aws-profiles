provider "aws" {
  alias = "profile"
  region = "${var.profile_region}"
  access_key="${var.profile_access_key}"
  secret_key="${var.profile_secret_key}"
}

# Parameter Store Group for segmentio/chamber access
resource "aws_iam_group" "use_parameter_store_group" {
  provider = "aws.profile"
  name = "UseParameterStoreGroup"
}

resource "aws_iam_group_policy" "use_parameter_store_group_policy" {
  provider = "aws.profile"
  name = "UseParameterStorePolicy"
  group = "${aws_iam_group.use_parameter_store_group.id}"

  policy = <<EOF
{
  "Version":"2012-10-17",
  "Effect":"Allow",
  "Action":[
    "ssm:DescribeParameters",
    "ssm:PutParameter",
    "ssm:GetParameters",
    "ssm:DeleteParameter"
  ],
  "Resource":[
    "arn:aws:ssm:us-east-1:667882779648:parameter/*"
  ]
}
EOF
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
      "Resource": "arn:aws:iam::${var.sandbox_account_id}:role/TerraformRole"
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::${var.nonprod_account_id}:role/TerraformRole"
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::${var.sandbox_account_id}:role/KopsRole"
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::${var.nonprod_account_id}:role/KopsRole"
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
      "Resource": "arn:aws:iam::${var.prod_account_id}:role/TerraformRole"
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::${var.prod_account_id}:role/KopsRole"
    }
  ]
}
EOF
}


