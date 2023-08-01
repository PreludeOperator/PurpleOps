resource "aws_security_group" "RDP" {
  vpc_id = aws_vpc.PurpleOps-VPC.id

  ingress {
    from_port   = 3389
    to_port     = 3389
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
    Name = "RDP-security-group"
  }
}

resource "aws_instance" "DC-1" {
	depends_on = [ aws_key_pair.PurpleOps-key, aws_internet_gateway.PurpleOps-IG ]
	ami           = "ami-07d6602d4c3d698e2" # Windows Server 2016 base
	instance_type = "t2.small"
	subnet_id = aws_subnet.BlueOps-Subnet.id
	vpc_security_group_ids = [aws_security_group.RDP.id]
	iam_instance_profile = "${aws_iam_instance_profile.purpleops-instance-profile.name}"
	associate_public_ip_address = "true"
	private_ip = "10.0.0.100"
	key_name = "PurpleOps"
	user_data = <<-EOF
<powershell>
try{
	if(!(get-process sysmon64 -ErrorAction SilentlyContinue)){
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12
		Invoke-WebRequest https://live.sysinternals.com/Sysmon64.exe -OutFile C:\Windows\Temp\Sysmon64.exe
		(curl https://raw.githubusercontent.com/Neo23x0/sysmon-config/master/sysmonconfig-export-block.xml -UseBasicParsing).Content > C:\Windows\Temp\sysmonconfig.xml
		C:\Windows\Temp\Sysmon64.exe -accepteula -i C:\Windows\Temp\sysmonconfig.xml
	}
}
catch{}
try{
	if(!(get-command aws -ErrorAction SilentlyContinue)){
		# Download AWS CLI tools
		msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi /qn
		sleep 60
		Restart-Computer
	}
}
catch{}
try{
	if (!(Test-Path C:\Windows\Temp\dc.ps1 -PathType Leaf)){
		# Download dc.ps1 from s3 and delete it.
		aws s3 cp ${local.object_s3_uri} C:\Windows\Temp\dc.ps1
		# aws s3 rm s3://terraform-20230623081717557100000001/dc.ps1 --no-sign-request
	}
}
catch{}
C:\Windows\Temp\dc.ps1
</powershell>
<persist>true</persist>
EOF

	root_block_device {
	volume_size           = "30"
	volume_type           = "gp3"
	encrypted             = false
	delete_on_termination = true
	}

	tags = {
	  Name = "DC-1"
	}
}

resource "aws_instance" "SRV-1" {
	depends_on = [ aws_key_pair.PurpleOps-key, aws_internet_gateway.PurpleOps-IG ]
	ami           = "ami-07d6602d4c3d698e2" # Windows Server 2016 base
	instance_type = "t2.small"
	subnet_id = aws_subnet.BlueOps-Subnet.id
	vpc_security_group_ids = [aws_security_group.RDP.id]
	associate_public_ip_address = "true"
	private_ip = "10.0.0.101"
	key_name = "PurpleOps"
	user_data = <<-EOF
<powershell>
try{
	if(!(get-process sysmon64 -ErrorAction SilentlyContinue)){ # Check if sysmon exists
		$ProgressPreference = 'SilentlyContinue'
		Invoke-WebRequest -Uri https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.8.1-windows-x86_64.zip -OutFile C:\Windows\Temp\elastic-agent-8.8.1-windows-x86_64.zip
		Expand-Archive C:\Windows\Temp\elastic-agent-8.8.1-windows-x86_64.zip -DestinationPath C:\Windows\Temp
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12
		Invoke-WebRequest https://live.sysinternals.com/Sysmon64.exe -OutFile C:\Windows\Temp\Sysmon64.exe
		(curl https://raw.githubusercontent.com/Neo23x0/sysmon-config/master/sysmonconfig-export-block.xml -UseBasicParsing).Content > C:\Windows\Temp\sysmonconfig.xml
		C:\Windows\Temp\Sysmon64.exe -accepteula -i C:\Windows\Temp\sysmonconfig.xml
	}
}
catch{}
if ((hostname) -ne "SRV-1"){ # Check if hostname is set
 net user Administrator Pa`$`$w0rd
 Set-DnsClientServerAddress -InterfaceIndex (Get-DnsClientServerAddress | Where-Object {$_.AddressFamily -eq '2' -and $_.InterfaceAlias -eq 'Ethernet'} | Select-Object -ExpandProperty InterfaceIndex) -ServerAddresses ('10.0.0.100') # Set DHCP to DC-1
 $PSDefaultParameterValues['Out-File:Encoding'] = 'utf8' # Change echo to UTF-8
 echo "10.0.10.10 duckdns.org www.duckdns.org aep.duckdns.org" >> C:\Windows\System32\drivers\etc\hosts # DNS for RedOps
 Rename-Computer -NewName "SRV-1" -Restart
}
# Enable insecure HTTPs
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
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls

while($true){
	sleep 20
	if((Invoke-RestMethod "https://10.0.0.10:5601/").html.head.title -eq "Elastic" -and (!(Test-Path -Path "C:\Program Files\Elastic"))){ # Check if elastic is installed
		sleep 600
		cd C:\Windows\Temp\elastic-agent-8.8.1-windows-x86_64
		$username = "elastic"
		$password= "Pa`$`$w0rd"
		$credential = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
		.\elastic-agent.exe install --url=https://10.0.0.10:8220 --enrollment-token=$(((Invoke-RestMethod "https://10.0.0.10:5601/api/fleet/enrollment_api_keys" -Headers @{Authorization=("Basic {0}" -f $credential)}).list | where "policy_id" -eq "agent-policy" | select-object "api_key").api_key) -i -n # Get policy id and enroll to fleet server
		break
	}
}
if ((Get-WmiObject Win32_ComputerSystem).Domain -ne "blueops.com"){
	sleep 600
	$Creds = New-Object pscredential -ArgumentList ([pscustomobject]@{ 
	UserName = "blueops.com\administrator" 
	Password = (ConvertTo-SecureString -String 'Pa$$w0rd' -AsPlainText -Force)[0]})
	Add-Computer -DomainName blueops.com -Credential $Creds -Restart -PassThru -Verbose > C:\Windows\Temp\ts.txt
}
</powershell>
<persist>true</persist>
EOF

	root_block_device {
	volume_size           = "30"
	volume_type           = "gp3"
	encrypted             = false
	delete_on_termination = true
	}

	tags = {
	  Name = "SRV-1"
	}
}