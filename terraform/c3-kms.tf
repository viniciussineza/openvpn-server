resource "aws_kms_key" "kms_key" {
  for_each = { for key in var.AWS_KMS_KEYS: key.NAME => key }
  description             = each.value.DESCRIPTION
  deletion_window_in_days = tonumber(each.value.DELETION_WINDOW_IN_DAYS)
  enable_key_rotation     = tobool(each.value.ENABLE_KEY_ROTATION)
  tags = {
    Name        = each.key
    Project     = each.value.PROJECT != null ? each.value.PROJECT : var.AWS_PROJECT 
    Environment = each.value.ENVIRONMENT != null ? each.value.ENVIRONMENT : var.AWS_ENVIRONMENT
    Group       = each.value.GROUP != null ? each.value.GROUP : var.AWS_GROUP
  }
}

resource "aws_kms_alias" "key_alias" {
  for_each = { for alias in var.AWS_KMS_KEY_ALIASES: alias.NAME => alias }
  name          = each.key
  target_key_id = "${aws_kms_key.kms_key[each.value.TARGET_KEY_ID].id}" 
}