resource "aws_instance" "ec2_instance"{
  ami = var.ubuntu_24_ami
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "first_ec2_key"
  vpc_security_group_ids = [ aws_security_group.allow_http.id , aws_security_group.allow_ssh]  
  subnet_id = aws_subnet.Public_Subnet.id

    user_data = <<-EOF
              #!/bin/bash
              sudo apt install -y apache2
              sudo systemctl start apache2
              echo "Hello, World" > /var/www/html./index.html
              EOF

  tags = {
    Name = "web_instance"
  }
}
