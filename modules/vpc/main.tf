resource "aws_vpc" "dev-vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"
    tags = {
      name = "${var.env}-${var.project}"
    } 
}
resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.dev-vpc.id
 cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
 
 tags = {
   Name = "Public_Subnet-${count.index + 1}"
 }
}
 
resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.dev-vpc.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
 
 tags = {
   Name = "Private_subnet-${count.index + 1}"
 }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "${var.env}-${var.project}-gw"
  }
}
resource "aws_route_table" "dev_route_table" {
 vpc_id = aws_vpc.dev-vpc.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
 }
 
 tags = {
   Name = "${var.env}-${var.project}_route_table"
 }
}
resource "aws_route_table_association" "public_subnet_rt_associate" {
  count = length(var.public_subnet_cidrs)  
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.dev_route_table.id
}
resource "aws_eip" "dev_eip"{
    vpc = true
    tags = {
        name = "${var.env}-${var.project}"
    }
}

resource "aws_nat_gateway" "dev-nat-gw" {
  allocation_id = aws_eip.dev_eip.id
  subnet_id         = aws_subnet.public_subnets[0].id
  #subnet_id         = "subnet-0e504c87f66f1d2b5"
}
resource "aws_route_table" "private_route_table" {
 vpc_id = aws_vpc.dev-vpc.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_nat_gateway.dev-nat-gw.id
 }
}
resource "aws_route_table_association" "private_subnet_rt_associate" {
  count = length(var.public_subnet_cidrs)  
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}
