
// resource "aws_subnet" "pub_subnet" {
// #    count                   = 1
//     vpc_id                  = aws_vpc.vpc.id
// #    cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1 + count.index)
//     cidr_block              = "10.0.0.0/22"
// }

// resource "aws_subnet" "pub_subnet" {
// #    count                   = 1
//     vpc_id                  = aws_vpc.vpc.id
// #    cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1 + count.index)
//     cidr_block              = "10.0.0.0/22"
// }

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "pub_subnet" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
}