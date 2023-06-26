provider "aws" {
	region = "ap-southeast-1" #(Singapore)
}

data "http" "ip" {
  url = "https://ifconfig.me/ip" # Get Current IP Address
}

locals {
  host_ip_address = ["${data.http.ip.response_body}/32"] # Format IP Address
}

resource "aws_key_pair" "PurpleOps-key" {
  key_name   = "PurpleOps"                # Generate SSH keys before running script
  public_key = file("./keys/id_rsa.pub")  # ssh-keygen -b 4096
}

