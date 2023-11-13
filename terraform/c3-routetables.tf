locals {
  associations = distinct(
    flatten(
      [ for association in var.AWS_ROUTE_TABLE_ASSOCIATIONS: {
        key         = "${association.SUBNET}.${association.ROUTE_TABLE}"
        subnet      = association.SUBNET
        route_table = association.ROUTE_TABLE
        } 
      ]
    )
  )
}

resource "aws_route_table" "route_table" {
  for_each = { for route_table in var.AWS_ROUTE_TABLE: route_table.NAME => route_table }
  vpc_id = [ for vpc in data.aws_vpc.vpc: vpc.id if vpc.name == each.value.VPC ][0]
  dynamic "route" {
    for_each = each.value.ROUTES != null ? [ each.value ] : []
    content {
      cidr_block = route.value.CIDR_BLOCK
      gateway_id = route.value.INTERNET_GATEWAY != null ? [ for internet_gateway in data.aws_internet_gateway.internet_gateway: internet_gateway.id if internet_gateway.tags.Name == route.value.INTERNET_GATEWAY ][0] : null
    }
  }
  tags = {
    Name        = each.key
    Project     = each.value.PROJECT != null ? each.value.PROJECT : var.AWS_PROJECT
    Environment = each.value.ENVIRONMENT != null ? each.value.ENVIRONMENT : var.AWS_ENVIRONMENT
    Group       = each.value.GROUP != null ? each.value.GROUP : var.AWS_GROUP
  }
}

resource "aws_route_table_association" "name" {
  for_each = { for association in local.associations : association.key => association }
  subnet_id = [][0] //TODO
  route_table_id = "${aws_route_table.route_table[each.value.route_table].id}"
}