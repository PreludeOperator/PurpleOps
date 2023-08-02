resource "aws_security_group" "RedOps" {
  vpc_id = aws_vpc.PurpleOps-VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.host_ip_address
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = local.host_ip_address
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = local.host_ip_address
  }
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = local.host_ip_address
  }
  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = local.host_ip_address
  }
  
  ingress {
    from_port   = 40056
    to_port     = 40056
    protocol    = "tcp"
    cidr_blocks = local.host_ip_address
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RedOps-security-group"
  }
}

# VM is 23.5GB, EBS is 30GB for TTPs, beacons etc
# Caldera, Havoc C2, apache2 w/ https
# havoc may not build sometimes, run (make ts-build) in /opt/havoc
resource "aws_instance" "RedOps" {
	ami           = "ami-0df7a207adb9748c7" # Ubuntu 22.04
	instance_type = "t2.medium"
	subnet_id = aws_subnet.RedOps-Subnet.id
	vpc_security_group_ids = [aws_security_group.RedOps.id]
	associate_public_ip_address = "true"
	private_ip = "10.0.10.10"
	key_name = "PurpleOps"
	depends_on = [aws_internet_gateway.PurpleOps-IG]
	user_data = <<-EOF
#!/bin/bash
sudo su

#######################
### Install Caldera ###
#######################
apt-get update -y
apt-get upgrade -y
apt-get install curl git make cmake -y
apt-get install -y git build-essential apt-utils cmake libfontconfig1 libglu1-mesa-dev libgtest-dev libspdlog-dev libboost-all-dev libncurses5-dev libgdbm-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev mesa-common-dev qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5websockets5 libqt5websockets5-dev qtdeclarative5-dev golang-go qtbase5-dev libqt5websockets5-dev python3-dev libboost-all-dev mingw-w64 nasm
mkdir /opt/caldera
git clone https://github.com/mitre/caldera.git --recursive /opt/caldera
apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-cache policy docker-ce
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin unzip -y
su ubuntu
yes "" | head -n 1 | sudo /opt/caldera/plugins/builder/install.sh
apt-get install python3-pip -y
pip3 install -r /opt/caldera/requirements.txt
#######################
### Install Caldera ###
#######################

sudo su
#############################
### Install HTTPS Caldera ###
#############################
apt-get install haproxy -y
openssl req -x509 -newkey rsa:4096  -out /opt/caldera/plugins/ssl/conf/certificate.pem -keyout /opt/caldera/plugins/ssl/conf/certificate.pem -nodes -subj "/C=SG/ST=Singapore/L=Singapore/O=RT PTE LTD/OU=IT Department/CN=duckdns.org"
cp /opt/caldera/plugins/ssl/templates/haproxy.conf /opt/caldera/plugins/ssl/conf/
sed -i 's/insecure_certificate.pem/certificate.pem/g' /opt/caldera/plugins/ssl/conf/haproxy.conf
sed -i '/port: 8888/i - ssl' /opt/caldera/conf/default.yml
#############################
### Install HTTPS Caldera ###
#############################

############################
### Install Havoc Server ###
############################
git clone https://github.com/HavocFramework/Havoc.git /opt/havoc
cd /opt/havoc
yes | head -n 1 | add-apt-repository ppa:deadsnakes/ppa
apt-get update
apt-get install python3.10 python3.10-dev -y
wget https://go.dev/dl/go1.20.5.linux-amd64.tar.gz -P /tmp
tar -C /usr/local -xzf /tmp/go1.20.5.linux-amd64.tar.gz
ln -sf /usr/local/go/bin/go /bin/go
cd teamserver
go mod download golang.org/x/sys
go mod download github.com/ugorji/go
cd ..
make ts-build
############################
### Install Havoc Server ###
############################


###############################
### Install Apache Redirect ###
###############################
apt-get install apache2 -y
a2enmod ssl rewrite proxy proxy_http
rm /etc/apache2/sites-enabled/000-default.conf
ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf
openssl genrsa -out duckdns.key 2048
openssl req -new -key duckdns.key -out duckdns.csr -subj "/C=SG/ST=Singapore/L=Singapore/O=RT PTE LTD/OU=IT Department/CN=duckdns.org"
cat << END > duckdns.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = duckdns.org
DNS.2 = www.duckdns.org
END
openssl x509 -req -in duckdns.csr -out duckdns.crt -days 365 -sha256 -extfile duckdns.ext -key duckdns.key
cp duckdns.crt /etc/ssl/certs/
cp duckdns.key /etc/ssl/private/
sed -i 's/\/etc\/ssl\/certs\/ssl-cert-snakeoil.pem/\/etc\/ssl\/certs\/duckdns.crt/' /etc/apache2/sites-enabled/default-ssl.conf
sed -i 's/\/etc\/ssl\/private\/ssl-cert-snakeoil.key/\/etc\/ssl\/private\/duckdns.key/' /etc/apache2/sites-enabled/default-ssl.conf
systemctl restart apache2
###############################
### Install Apache Redirect ###
###############################

#####################
### Install Vectr ###
#####################
apt-get install \
    ca-certificates \
    curl \
    gnupg \
    unzip \
    lsb-release
### Uncomment when docker is not installed yet:
#mkdir -p /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#echo \
#  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
#apt-get update -y
#apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin unzip -y
mkdir -p /opt/vectr
cd /opt/vectr
wget https://github.com/SecurityRiskAdvisors/VECTR/releases/download/ce-8.8.1/sra-vectr-runtime-8.8.1-ce.zip 
unzip sra-vectr-runtime-8.8.1-ce.zip
sed -i 's/sravectr.internal/blueops.com/g' .env
sed -i 's/Test1234/Pa\$\$w0rd/g' .env
sed -i "s/CHANGEMENOW/`tr -dc A-Za-z0-9 </dev/urandom | head -c 12`/g" .env
sed -i "s/WSӠ\$8É\*X\&\*8HѲk\!^£/`tr -dc A-Za-z0-9 </dev/urandom | head -c 16`/g" .env
sed -i "s/VПlδ4x%vЋs\$fIT@b€/`tr -dc A-Za-z0-9 </dev/urandom | head -c 16`/g" .env
#docker compose up -d
#####################
### Install Vectr ###
#####################

chown -R ubuntu:ubuntu /opt
EOF

	root_block_device {
	volume_size           = "30"
	volume_type           = "gp3"
	encrypted             = false
	delete_on_termination = true
	}

	tags = {
	Name = "RedOps"
	}
}