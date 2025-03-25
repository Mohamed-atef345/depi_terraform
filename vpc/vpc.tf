resource "aws_vpc" "WebAppVPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "WebAppVPC"
  }
}
resource "aws_subnet" "Public_Subnet01" {
  vpc_id            = aws_vpc.WebAppVPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public_Subnet01"
  }
}

resource "aws_subnet" "Public_Subnet02" {
  vpc_id            = aws_vpc.WebAppVPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"


  tags = {
    Name = "Public_Subnet02"
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
  subnet_id      = aws_subnet.Public_Subnet01.id
  route_table_id = aws_route_table.WebAppRouteTable.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.Public_Subnet02.id
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

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "security_egress_rule" {
  security_group_id = aws_security_group.allow_http.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.WebAppVPC.id

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "security_ingress_rule_ssh" {
  security_group_id = aws_security_group.allow_ssh.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "security_egress_rule_ssh" {
  security_group_id = aws_security_group.allow_ssh.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
