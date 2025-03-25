output "instance_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "HTTP_SG_ID" {
  value = aws_security_group.allow_http.id
}

output "vpc_id" {
  value = aws_vpc.WebAppVPC.id
}

output "subnets_ids" {
  value = [aws_subnet.Public_Subnet01.id, aws_subnet.Public_Subnet02.id]
}
