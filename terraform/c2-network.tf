resource "aws_vpc" "vpc" {
  for_each = { for vpc in var.AWS_VPCS: vpc.NAME => vpc }
  cidr_block = each.value.CIDR_BLOCK
  tags = {
    Name        = each.key
    Project     = each.value.PROJECT != null ? each.value.PROJECT : var.AWS_PROJECT
    Environment = each.value.ENVIRONMENT != null ? each.value.ENVIRONMENT : var.AWS_ENVIRONMENT
    Group       = each.value.GROUP != null ? each.value.GROUP : var.AWS_GROUP
  }
}

resource "aws_subnet" "subnet" {
  for_each = { for subnet in var.AWS_SUBNETS: subnet.NAME => subnet }
  vpc_id              = "${aws_vpc.vpc[each.value.VPC].id}"
  cidr_block          = each.value.CIDR_BLOCK
  availability_zone = each.value.AVAILABILITY_ZONE
  tags = {
    Name        = each.key
    Project     = each.value.PROJECT != null ? each.value.PROJECT : var.AWS_PROJECT
    Environment = each.value.ENVIRONMENT != null ? each.value.ENVIRONMENT : var.AWS_ENVIRONMENT
    Group       = each.value.GROUP != null ? each.value.GROUP : var.AWS_GROUP
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  for_each = { for internet_gateway in var.AWS_INTERNET_GATEWAYS: internet_gateway.NAME => internet_gateway }
  vpc_id = "${aws_vpc.vpc[each.value.VPC].id}"
  tags = {
    Name        = each.key
    Project     = each.value.PROJECT != null ? each.value.PROJECT : var.AWS_PROJECT
    Environment = each.value.ENVIRONMENT != null ? each.value.ENVIRONMENT : var.AWS_ENVIRONMENT
    Group       = each.value.GROUP != null ? each.value.GROUP : var.AWS_GROUP
  }
}