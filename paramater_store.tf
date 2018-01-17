# defines a kms key with the necessary alias for use with segmentio/chamber
resource "aws_kms_key" "parameter_store" {
  provider = "aws.profile"
  description             = "Parameter store kms master key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "parameter_store_alias" {
  provider = "aws.profile"
  name          = "alias/parameter_store_key"
  target_key_id = "${aws_kms_key.parameter_store.id}"
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
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeParameters",
                "ssm:PutParameter",
                "ssm:GetParameters",
                "ssm:DeleteParameter"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
