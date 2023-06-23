provider "aws" {
	region = "ap-southeast-1" # $$$ ap-southeast-1 (Singapore) > ap-south-1 (India) > us-east-1 (US)
}

data "http" "ip" {
  url = "https://ifconfig.me/ip"
}

locals {
  host_ip_address = ["${data.http.ip.response_body}/32"]
}

resource "aws_key_pair" "PurpleOps-key" {
  key_name   = "PurpleOps"
  public_key = file("./keys/id_rsa.pub")  # ssh-keygen -b 4096
}

