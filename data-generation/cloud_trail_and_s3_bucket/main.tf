# Resource to create a s3 bucket policy document
data "aws_iam_policy_document" "example" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.example.arn]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/example"]
    }
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.example.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/example"]
    }
  }
}

# Fetch data of caller identity
data "aws_caller_identity" "current" {}

# Fetch data of partition
data "aws_partition" "current" {}

# Get current region of aws account
data "aws_region" "current" {}

# Resource to create a cloudtrail
resource "aws_cloudtrail" "example" {
  depends_on                    = [aws_s3_bucket_policy.example]
  name                          = "example"
  s3_bucket_name                = aws_s3_bucket.example.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  is_multi_region_trail         = false # set false to violate rule
  enable_logging                = false
}

# Resource to create a s3 bucket
resource "aws_s3_bucket" "example" {
  bucket        = "example-trail-bucket-yash"
  force_destroy = true # if s3 bucket is not empty still delete s3 bucket forcefully.
}

# Attach created s3 bucket policy to s3 bucket
resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.example.id
  policy = data.aws_iam_policy_document.example.json
}

# Allow all traffic to the S3 bucket and ensure that public access is not blocked.
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false # this is use for allow public access to s3 bucket
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  depends_on              = [aws_cloudtrail.example]
}

# S3 bucket ownership to BucketOwnerPreferred
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_cloudtrail.example]
}

# Give public Read and Write to the s3 bucket
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
    aws_cloudtrail.example,
  ]

  bucket = aws_s3_bucket.example.id
  acl    = "public-read-write" # give globally read-write permission to s3 bucket for violate rules.
}
