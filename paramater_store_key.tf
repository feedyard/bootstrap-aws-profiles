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