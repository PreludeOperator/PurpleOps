resource "aws_security_group" "RDP" {
  vpc_id = aws_vpc.PurpleOps-VPC.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = local.host_ip_address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDP-security-group"
  }
}

resource "aws_instance" "DC-1" {
	ami           = "ami-0b003c3b118dbe3fe"
	instance_type = "t2.micro"
	subnet_id = aws_subnet.BlueOps-Subnet.id
	vpc_security_group_ids = [aws_security_group.RDP.id]
	associate_public_ip_address = "false"
	private_ip = "10.0.0.100"
	key_name = "PurpleOps"
	depends_on = [aws_internet_gateway.PurpleOps-IG]
	user_data = <<EOF
<powershell>
try{
	if(!(aws help)){
		msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi /qn
		sleep 60
		Restart-Computer
	}
}
catch{}
try{
	if (!(dir C:\Windows\Temp\dc.ps1)){
		aws s3 cp ${var.object_s3_uri} C:\Windows\Temp\dc.ps1 --no-sign-request
		aws s3 rm s3://terraform-20230623081717557100000001/dc.ps1 --no-sign-request
	}
catch{}
Set-ExecutionPolicy RemoteSigned 
C:\Windows\Temp\dc.ps1
</powershell>
<persist>true</persist>
EOF

	root_block_device {
	volume_size           = "30"
	volume_type           = "gp3"
	encrypted             = true
	delete_on_termination = true
	}

	tags = {
	  Name = "DC-1"
	}
}

resource "aws_instance" "SRV-1" {
	ami           = "ami-0b003c3b118dbe3fe"
	instance_type = "t2.micro"
	subnet_id = aws_subnet.BlueOps-Subnet.id
	vpc_security_group_ids = [aws_security_group.RDP.id]
	associate_public_ip_address = "false"
	private_ip = "10.0.0.101"
	key_name = "PurpleOps"
	depends_on = [aws_internet_gateway.PurpleOps-IG]
	user_data = <<EOF
<powershell>
if ((hostname) -ne "SRV-1"){
 net user Administrator Pa`$`$w0rd
 Set-DnsClientServerAddress -InterfaceIndex (Get-DnsClientServerAddress | Where-Object {$_.AddressFamily -eq '2' -and $_.InterfaceAlias -eq 'Ethernet'} | Select-Object -ExpandProperty InterfaceIndex) -ServerAddresses ('10.0.0.100')
 $PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
 echo "10.0.0.10.10 duckdns.com www.duckdns.com aep.duckdns.com" >> C:\Windows\System32\drivers\etc\hosts
 Rename-Computer -NewName "SRV-1" -Restart
}
if ((Get-WmiObject Win32_ComputerSystem).Domain -ne "blueops.com"){
	while ((Get-WmiObject Win32_ComputerSystem).Domain -ne "blueops.com"){
	 Start-Sleep -Seconds 60
	 $Creds = New-Object pscredential -ArgumentList ([pscustomobject]@{
		UserName = "administrator"
		Password = (ConvertTo-SecureString -String 'Pa$$w0rd' -AsPlainText -Force)[0]
	 })
	 Add-Computer -DomainName dc-1.blueops.com -Credential $Creds -Restart
	}
}
try{
	while(!(Invoke-RestMethod "https://10.0.0.10:5601/")){
		if((Invoke-RestMethod "https://10.0.0.10:5601/") -and (Test-Path -Path "C:\Program Files\Elastic")){
			$ProgressPreference = 'SilentlyContinue'
			Invoke-WebRequest -Uri https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.8.1-windows-x86_64.zip -OutFile elastic-agent-8.8.1-windows-x86_64.zip
			Expand-Archive .\elastic-agent-8.8.1-windows-x86_64.zip -DestinationPath .
			cd elastic-agent-8.8.1-windows-x86_64
			$username = "elastic"
			$password= "Pa`$`$w0rd"
			$credential = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
			add-type @"
				using System.Net;
				using System.Security.Cryptography.X509Certificates;
				public class TrustAllCertsPolicy : ICertificatePolicy {
					public bool CheckValidationResult(
						ServicePoint srvPoint, X509Certificate certificate,
						WebRequest request, int certificateProblem) {
						return true;
					}
				}
			"@
			[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
			.\elastic-agent.exe install --url=https://10.0.0.10:8220 --enrollment-token=$(((Invoke-RestMethod "https://10.0.0.10:5601/api/fleet/enrollment_api_keys" -Headers @{Authorization=("Basic {0}" -f $credential)}).list | where "policy_id" -eq "agent-policy" | select-object "api_key").api_key) -i -n
		}
	}
}
catch{}

</powershell>
<persist>true</persist>
EOF

	root_block_device {
	volume_size           = "30"
	volume_type           = "gp3"
	encrypted             = true
	delete_on_termination = true
	}

	tags = {
	  Name = "SRV-1"
	}
}