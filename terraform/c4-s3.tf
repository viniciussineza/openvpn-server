resource "aws_s3_bucket" "bucket" {
  for_each = { for bucket in var.AWS_S3_BUCKETS: bucket.NAME => bucket }
  bucket   = each.key
  tags     = {
    Name        = each.key
    Project     = each.value.PROJECT != null ? each.value.PROJECT : var.AWS_PROJECT 
    Environment = each.value.ENVIRONMENT != null ? each.value.ENVIRONMENT : var.AWS_ENVIRONMENT
    Group       = each.value.GROUP != null ? each.value.GROUP : var.AWS_GROUP
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  for_each = { for bucket in var.AWS_S3_BUCKETS: bucket.NAME => bucket.BLOCK if bucket.BLOCK != null }
  bucket                  = "${aws_s3_bucket.bucket[each.key].id}"
  block_public_acls       = tobool(each.value.BLOCK_PUBLIC_ACLS)
  block_public_policy     = tobool(each.value.BLOCK_PUBLIC_POLICYS)
  ignore_public_acls      = tobool(each.value.IGNORE_PUBLIC_ACLS) 
  restrict_public_buckets = tobool(each.value.RESTRICT_PUBLIC_BUCKETS)
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  for_each = { for bucket in var.AWS_S3_BUCKETS: bucket.NAME => bucket.VERSIONING if bucket.VERSIONING != null }
  bucket   = "${aws_s3_bucket.bucket[each.key].id}"
  versioning_configuration {
    status = each.value.STATUS
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  for_each = { for bucket in var.AWS_S3_BUCKETS: bucket.NAME => bucket.ENCRYPTION if bucket.ENCRYPTION != null }
  bucket = "${aws_s3_bucket.bucket[each.key].id}"
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = [ for key in data.aws_kms_key.kms_key: key.arn if key.key_id == each.value.KEY ][0]
      sse_algorithm     = each.value.SSE_ALGORITHM 
    }
  }
}