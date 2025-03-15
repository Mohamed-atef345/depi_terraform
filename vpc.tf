resource "aws_vpc" "WebAppVPC" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "WebAppVPC"
    }
}
resource "aws_subnet" "Public_Subnet" {
  vpc_id     = aws_vpc.WebAppVPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public_Subnet"
  }
}

resource "aws_internet_gateway" "WebAppIG" {
  vpc_id = aws_vpc.WebAppVPC.id

  tags = {
    Name = "WebAppIG"
  }
}

resource "aws_route_table" "WebAppRouteTable" {
  vpc_id = aws_vpc.WebAppVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.WebAppIG.id
  }

  tags = {
    Name = "WebAppRouteTable"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Public_Subnet.id
  route_table_id = aws_route_table.WebAppRouteTable.id
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.WebAppVPC.id

  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "security_ingress_rule" {
  security_group_id = aws_security_group.allow_http.id

  cidr_ipv4   = ["0.0.0.0/0"]
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "security_egress_rule" {
  security_group_id = aws_security_group.allow_http.id

  cidr_ipv4   = ["0.0.0.0/0"]
  from_port   = 0
  ip_protocol = "-1"
  to_port     = 0
}



