data "aws_kms_key" "kms_key" {
  for_each = { for bucket in var.AWS_S3_BUCKETS: bucket.NAME => bucket.ENCRYPTION if bucket.ENCRYPTION != null }
  key_id = each.value.KEY
  depends_on = [ aws_kms_key.kms_key ]
}

output "key" {
  value = data.aws_kms_key.kms_key
}