resource "aws_security_group" "BlueOps" {
  vpc_id = aws_vpc.PurpleOps-VPC.id

  ingress {
    from_port   = 5601
    to_port     = 5601
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
    Name = "BlueOps-security-group"
  }
}

resource "aws_instance" "BlueOps" {
	ami           = "ami-0df7a207adb9748c7" # Ubuntu 22.04
	instance_type = "t2.medium"
	subnet_id = aws_subnet.BlueOps-Subnet.id
	vpc_security_group_ids = [aws_security_group.BlueOps.id]
	associate_public_ip_address = "true"
	private_ip = "10.0.0.10"
	key_name = "PurpleOps"
	depends_on = [aws_internet_gateway.PurpleOps-IG]
	user_data = <<-EOF
#!/bin/bash
sudo su
apt-get update
apt-get upgrade -y

#######################
### Install Elastic ###
#######################
apt-get install curl -y
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/elastic-archive-keyring.gpg
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
apt-get update
apt-get install elasticsearch -y | grep -oP "(?<=is : ).*" | tr -d '[:space:]' > ~/elastic_password.txt
sed -e '/cluster.initial_master_nodes/ s/^#*/#/' -i /etc/elasticsearch/elasticsearch.yml
echo "discovery.type: single-node" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
#######################
### Install Elastic ###
#######################

######################
### Install Kibana ###
######################
apt-get install kibana
/usr/share/kibana/bin/kibana-encryption-keys generate -q
echo "server.host: \"0.0.0.0\"" | sudo tee -a /etc/kibana/kibana.yml
systemctl enable elasticsearch kibana --now
/usr/share/kibana/bin/kibana-setup -t `/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana`
/usr/share/elasticsearch/bin/elasticsearch-certutil ca --out elastic-stack-ca.p12 --pass ""
/usr/share/elasticsearch/bin/elasticsearch-certutil cert --ca elastic-stack-ca.p12 --out kibana-server.p12 --pass "" --ca-pass ""
openssl pkcs12 -in /usr/share/elasticsearch/kibana-server.p12 -out /etc/kibana/kibana-server.crt -clcerts -nokeys -password pass:
openssl pkcs12 -in /usr/share/elasticsearch/kibana-server.p12 -out /etc/kibana/kibana-server.key -nocerts -nodes -password pass:
chown root:kibana /etc/kibana/kibana-server.key
chown root:kibana /etc/kibana/kibana-server.crt
chmod 660 /etc/kibana/kibana-server.key
chmod 660 /etc/kibana/kibana-server.crt
echo "server.ssl.enabled: true" | sudo tee -a /etc/kibana/kibana.yml
echo "server.ssl.certificate: /etc/kibana/kibana-server.crt" | sudo tee -a /etc/kibana/kibana.yml
echo "server.ssl.key: /etc/kibana/kibana-server.key" | sudo tee -a /etc/kibana/kibana.yml
echo "server.publicBaseUrl: \"https://`curl http://169.254.169.254/latest/meta-data/public-ipv4`:5601\"" | sudo tee -a /etc/kibana/kibana.yml
systemctl restart elasticsearch kibana
######################
### Install Kibana ###
######################

####################################
### Add Integrations to policies ###
####################################
sleep 120
password=$(cat ~/elastic_password.txt)
policy_id=$(curl -u elastic:$password -X POST --insecure \
  --url https://10.0.0.10:5601/api/fleet/agent_policies?sys_monitoring=true \
  --header 'content-type: application/json' \
  --header 'kbn-xsrf: true' \
  --data '{"id":"agent-policy","name":"Default Agent policy","namespace":"default","monitoring_enabled":["logs","metrics"]}' 2>&1 \
  | grep -oP '(?<="id":")[^"]+')
curl -u elastic:$password -X POST --insecure \
  --url https://10.0.0.10:5601/api/fleet/package_policies \
  --header 'content-type: application/json' \
  --header 'kbn-xsrf: true' \
  -d '{"policy_id": "'$policy_id'", "package": { "name": "network_traffic", "version": "1.18.0" }, "name": "network_traffic-1", "description": "", "namespace": "default", "inputs": { "network-packet": { "enabled": true, "vars": { "never_install": false }, "streams": { "network_traffic.amqp": { "enabled": true, "vars": { "port": [ 5672 ], "geoip_enrich": true, "tags": [] } }, "network_traffic.cassandra": { "enabled": true, "vars": { "port": [ 9042 ], "geoip_enrich": true, "ignored_ops": [], "tags": [] } }, "network_traffic.dhcpv4": { "enabled": true, "vars": { "port": [ 67, 68 ], "geoip_enrich": true, "tags": [] } }, "network_traffic.dns": { "enabled": true, "vars": { "port": [ 53 ], "geoip_enrich": true, "tags": [] } }, "network_traffic.flow": { "enabled": true, "vars": { "geoip_enrich": true, "period": "10s", "timeout": "30s", "tags": [] } }, "network_traffic.http": { "enabled": true, "vars": { "port": [ 80, 8080, 8000, 5000, 8002 ], "hide_keywords": [], "send_headers": [], "redact_headers": [], "include_body_for": [], "include_request_body_for": [], "include_response_body_for": [], "tags": [] } }, "network_traffic.icmp": { "enabled": true, "vars": { "geoip_enrich": true, "tags": [] } }, "network_traffic.memcached": { "enabled": true, "vars": { "port": [ 11211 ], "geoip_enrich": true, "tags": [] } }, "network_traffic.mongodb": { "enabled": true, "vars": { "port": [ 27017 ], "geoip_enrich": true, "tags": [] } }, "network_traffic.mysql": { "enabled": true, "vars": { "port": [ 3306, 3307 ], "geoip_enrich": true, "tags": [] } }, "network_traffic.nfs": { "enabled": true, "vars": { "port": [ 2049 ], "geoip_enrich": true, "tags": [] } }, "network_traffic.pgsql": { "enabled": true, "vars": { "port": [ 5432 ], "geoip_enrich": true, "tags": [] } }, "network_traffic.redis": { "enabled": true, "vars": { "port": [ 6379 ], "geoip_enrich": true, "tags": [] } }, "network_traffic.sip": { "enabled": true, "vars": { "port": [ 5060 ], "geoip_enrich": true, "use_tcp": false, "tags": [] } }, "network_traffic.thrift": { "enabled": true, "vars": { "port": [ 9090 ], "geoip_enrich": true, "idl_files": [], "tags": [] } }, "network_traffic.tls": { "enabled": true, "vars": { "port": [ 443, 993, 995, 5223, 8443, 8883, 9243 ], "geoip_enrich": true, "fingerprints": [], "tags": [] } } } } } }'
curl -u elastic:$password -X POST --insecure \
  --url https://10.0.0.10:5601/api/fleet/package_policies \
  --header 'content-type: application/json' \
  --header 'kbn-xsrf: true' \
  -d '{
  "policy_id": "'$policy_id'",
  "package": {
    "name": "winlog",
    "version": "1.16.0"
  },
  "name": "sysmon-1",
  "description": "",
  "namespace": "default",
  "inputs": {
    "winlogs-winlog": {
      "enabled": true,
      "streams": {
        "winlog.winlog": {
          "enabled": true,
          "vars": {
            "channel": "Microsoft-Windows-Sysmon/Operational",
            "data_stream.dataset": "winlog.winlog",
            "preserve_original_event": false
          }
        }
      }
    }
  }
}'
curl -u elastic:$password -X POST --insecure \
  --url https://10.0.0.10:5601/api/fleet/package_policies \
  --header 'content-type: application/json' \
  --header 'kbn-xsrf: true' \
  -d '{
  "policy_id": "'$policy_id'",
  "package": {
    "name": "winlog",
    "version": "1.16.0"
  },
  "name": "powershell-1",
  "description": "",
  "namespace": "default",
  "inputs": {
    "winlogs-winlog": {
      "enabled": true,
      "streams": {
        "winlog.winlog": {
          "enabled": true,
          "vars": {
            "channel": "Microsoft-Windows-PowerShell/Operational",
            "data_stream.dataset": "winlog.winlog",
            "preserve_original_event": false
          }
        }
      }
    }
  }
}'
####################################
### Add Integrations to policies ###
####################################

############################
### Install Fleet Server ###
############################
fleet_policy_id=$(curl -u elastic:$password -X POST --insecure \
  --url https://10.0.0.10:5601/api/fleet/agent_policies?sys_monitoring=true \
  --header 'content-type: application/json' \
  --header 'kbn-xsrf: true' \
  --data '{
  "name":"Fleet policy",
  "namespace":"default",
  "description": "",
  "has_fleet_server": "true"
  }' 2>&1 \
  | grep -oP '(?<="id":")[^"]+')
curl -u elastic:$password -X POST --insecure \
  --url https://10.0.0.10:5601/api/fleet/fleet_server_hosts \
  --header 'content-type: application/json' \
  --header 'kbn-xsrf: true' \
  --data '{
    "id": "'$fleet_policy_id'",
    "name": "Fleet Server",
    "is_default": true,
    "host_urls": [
      "https://10.0.0.10:8220"
  ]
}'

token=$(curl -u elastic:$password -X POST --insecure \
	--url "https://10.0.0.10:9200/_security/service/elastic/fleet-server/credential/token/" 2>&1 \
	| grep -oP '(?<="value":")[^"]+')
curl -L -O https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.8.1-linux-x86_64.tar.gz
tar xzvf elastic-agent-8.8.1-linux-x86_64.tar.gz
cd elastic-agent-8.8.1-linux-x86_64
./elastic-agent install \
  --fleet-server-es=https://10.0.0.10:9200 \
  --fleet-server-service-token=$token \
  --fleet-server-policy=$fleet_policy_id \
  --fleet-server-es-ca-trusted-fingerprint=$(openssl x509 -fingerprint -sha256 -in /etc/elasticsearch/certs/http_ca.crt | grep -oP '(?<=Fingerprint=)[0-9A-F:]+' | tr -d ':') \
  --fleet-server-port=8220 \
  -i -n
############################
### Install Fleet Server ###
############################

printf "y\nPa\$\$w0rd\nPa\$\$w0rd" | /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic -i
EOF

	root_block_device {
	volume_size           = "60" # Probably will last 1 week
	volume_type           = "gp3"
	encrypted             = false
	delete_on_termination = true
	}

	tags = {
	  Name = "BlueOps"
	}
}
