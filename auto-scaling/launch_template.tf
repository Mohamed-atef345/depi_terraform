resource "aws_launch_template" "AutoScalingLaunchTemplate" {
  name = "WebAppLaunchTemplate"

  image_id = var.ubuntu_24_ami

  instance_type = "t2.micro"

  key_name = var.key_name

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "WebAppLaunchTemplate"
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.HTTP_SG_ID, var.SSH_SG_ID]
  }

  user_data = filebase64("${path.module}/apache_install.sh")
}