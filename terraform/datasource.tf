locals {
  internet_gateways = distinct(
    flatten(
      [ for route_table in var.AWS_ROUTE_TABLE: [
        for internet_gateway in route_table.ROUTES: internet_gateway.INTERNET_GATEWAY if internet_gateway.INTERNET_GATEWAY != null 
        ] 
      ]
    )
  )
}

data "aws_vpc" "vpc" {
  for_each = { for vpc in var.AWS_ROUTE_TABLE: vpc.VPC => vpc }
  filter {
    name   = "tag:Name"
    values = [each.key]
  }
}

data "aws_internet_gateway" "internet_gateway" {
  count = length(local.internet_gateways)
  filter{
    name   = "tag:Name" 
    values = [ local.internet_gateways[count.index] ]
  }
}