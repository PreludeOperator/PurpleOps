provider "aws" {
  region = "ap-southeast-1" # $$$ ap-southeast-1 (Singapore) > ap-south-1 (India) > us-east-1 (US)
}

data "http" "ip" {
  url = "https://ifconfig.me/ip"
}

locals {
  host_ip_address = ["${data.http.ip.response_body}/32"]
}

#Resource to create a SSH private key
resource "tls_private_key" "PurpleOps-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "PurpleOps-key" {
  key_name   = "PurpleOps"
  #public_key = file("./keys/id_rsa.pub")
  public_key = tls_private_key.PurpleOps-key.public_key_openssh
}

resource "local_file" "local_key_pair" {
  filename = "PurpleOps-key.pem"
  file_permission = "0400"
  content = tls_private_key.PurpleOps-key.private_key_pem
}

/*
provisioner "local-exec"{
    command = "echo '${tls_private_key.PurpleOps-key.private_key_pem}' > ./PurpleOps-key.pem"
  }
}
*/