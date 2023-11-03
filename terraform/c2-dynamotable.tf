resource "aws_dynamodb_table" "dynamo_table" {
  for_each = { for table in var.AWS_DYNAMODB_TABLES: table.NAME => table }
  name           = each.key
  hash_key       = each.value.HASH_KEY
  attribute {
    name = each.value.ATTRIBUTE.NAME
    type = each.value.ATTRIBUTE.TYPE
  }
  read_capacity  = tonumber(each.value.READ_CAPACITY)
  write_capacity = tonumber(each.value.WRITE_CAPACITY)
  tags = {
    Name        = each.key
    Project     = each.value.PROJECT != null ? each.value.PROJECT : var.AWS_PROJECT 
    Environment = each.value.ENVIRONMENT != null ? each.value.ENVIRONMENT : var.AWS_ENVIRONMENT
    Group       = each.value.GROUP != null ? each.value.GROUP : var.AWS_GROUP
  }
}