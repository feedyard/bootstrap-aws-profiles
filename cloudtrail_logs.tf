resource "aws_cloudtrail" "feedyard_cloudtrail_logs" {
  provider = "aws.profile"
  name = "FeedyardCloudtrailLogs"
  enable_logging = "true"
  include_global_service_events = "true"
  is_multi_region_trail = "true"
  include_global_service_events = "true"
  s3_bucket_name = "${var.cloudtrail_bucket_name}"
}

resource "aws_s3_bucket" "cloudtrail_logs" {
  provider = "aws.profile"
  bucket = "${var.cloudtrail_bucket_name}"
  force_destroy = true

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.cloudtrail_bucket_name}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": [
              "arn:aws:s3:::${var.cloudtrail_bucket_name}/AWSLogs/${var.profile_account_id}/*",
              "arn:aws:s3:::${var.cloudtrail_bucket_name}/AWSLogs/${var.sandbox_account_id}/*",
              "arn:aws:s3:::${var.cloudtrail_bucket_name}/AWSLogs/${var.nonprod_account_id}/*",
              "arn:aws:s3:::${var.cloudtrail_bucket_name}/AWSLogs/${var.prod_account_id}/*"
            ],
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}

//resource "aws_iam_group" "read_cloudtrail_logs_group" {
//  provider = "aws.profile"
//  name = "ReadCloudtrailLogsGroup"
//}
//
//resource "aws_iam_group_policy" "read_cloudtrail_logs_group_policy" {
//  provider = "aws.profile"
//  name = "ReadCloudtrailLogsPolicy"
//  group = "${aws_iam_group.read_cloudtrail_logs_group.id}"
//
//  policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Effect": "Allow",
//      "Action": [
//        "s3:Listucket",
//        "s3:GetObject",
//        "s3:GetObjectVersion"
//      ],
//      "Resource": "arn:aws:s3:::feedyard-profile-cloudtraillogs"
//    }
//  ]
//}
//EOF
//}
