output "BlueOps-IP-Address" {
  value       = aws_instance.BlueOps.public_ip
}

output "RedOps-IP-Address" {
  value       = aws_instance.RedOps.public_ip
}

output "SRV-1-IP-Address" {
  value       = aws_instance.SRV-1.public_ip
}

output "DC-1-IP-Address" {
  value       = aws_instance.DC-1.public_ip
}