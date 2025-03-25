variable "ubuntu_24_ami" {
  type    = string
  default = "ami-04b4f1a9cf54c11d0"
}

variable "HTTP_SG_ID" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

# variable "public_subnet01" {
#   type = string
# }

# variable "public_subnet02" {
#   type = string
# }
