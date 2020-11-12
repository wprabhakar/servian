resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
}

resource "aws_route_table_association" "route_table_association" {
    count          = var.az_count
    subnet_id      = element(aws_subnet.pub_subnet.*.id, count.index)
    route_table_id = aws_route_table.public.id
}
