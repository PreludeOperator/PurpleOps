# Warning

```
Do not login to anything until 20mins is up, the process seems to be very fragile.
30mins to reduce the lag on elastic.
BlueOps and RedOps might require large instances (long period usage may crash for medium?)
```

## Remove S3 and IAM policy linked to EC2 (DC-1)
> Currently not working as EC2 uses RDP

```
resource "null_resource" "dc_script" {
  connection {
    host     = "${aws_instance.DC-1.public_ip}"
    type     = "winrm"
    user     = "administrator"
    password = "Pa$$w0rd"
  }

  provisioner "file" {
    source      = "./dc.ps1"
    destination = "C:/Windows/Temp/dc.ps1"
  }
}
```