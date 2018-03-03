# Parameter Store Group for segmentio/chamber access
resource "aws_iam_group" "default_iam_user_group" {
  name = "DefaultIAMUsersGroup"
}

resource "aws_iam_group_policy" "assume_readonly_role_group_policy" {
  name = "AssumeReadonlyRolePolicy"
  group = "${aws_iam_group.default_iam_user_group.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::${var.profile_account_id}:role/ReadOnlyRole"
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::${var.sandbox_account_id}:role/ReadOnlyRole"
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::${var.nonprod_account_id}:role/ReadOnlyRole"
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::${var.prod_account_id}:role/ReadOnlyRole"
    }
  ]
}
EOF
}

resource "aws_iam_group_policy" "use_parameter_store_group_policy" {
  name = "UseParameterStorePolicy"
  group = "${aws_iam_group.default_iam_user_group.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeParameters",
                "ssm:PutParameter",
                "ssm:GetParameters",
                "ssm:DeleteParameter",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# defines a kms key with the necessary alias for use with segmentio/chamber
resource "aws_kms_key" "parameter_store" {
  description             = "Parameter store kms master key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "parameter_store_alias" {
  name          = "alias/parameter_store_key"
  target_key_id = "${aws_kms_key.parameter_store.id}"
}

# nonprod accounts
resource "aws_iam_group" "assume_nonprod_role_group" {
  name = "AssumeNonprodRoleGroup"
}

resource "aws_iam_group_policy" "assume_nonprod_role_group_policy" {
  name = "AssumeNonprodRolePolicy"
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
  name = "AssumeProdRoleGroup"
}

resource "aws_iam_group_policy" "assume_prod_role_group_policy" {
  name = "AssumeProdRolePolicy"
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

# profile account
resource "aws_iam_group" "assume_profile_role_group" {
  name = "AssumeProfileRoleGroup"
}

resource "aws_iam_group_policy" "assume_profile_role_group_policy" {
  name = "AssumeProfileRolePolicy"
  group = "${aws_iam_group.assume_profile_role_group.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::${var.profile_account_id}:role/TerraformRole"
    }
  ]
}
EOF
}
