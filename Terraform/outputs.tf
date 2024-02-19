##############   ==>> Outputs <<==  ##############



## ==>> Ununtu Latest ID:
output "UbuntuLatest_id" {
  value = data.aws_ami.latest_ubuntu1.id
}

## ==>> Ununtu Latest Name:
output "UbuntuLatest_name" {
  value = data.aws_ami.latest_ubuntu1.name
}

## ==>> Windows Latest ID:
output "WindowsLatest_id" {
  value = data.aws_ami.latest_windows.id
}

## ==>> Windows Latest Name:
output "WindowsLatest_name" {
  value = data.aws_ami.latest_windows.name
}

## ==>> Availability Zones Names:
output  "AvailabilityZones_names" {
  value = data.aws_availability_zones.available.names
}

## ==>> Instaces Types:
output "InstanceType_ubuntu" {
  value = resource.aws_instance.my_ubuntu.instance_type
}

output "InstanceType_windows" {
  value = resource.aws_instance.my_win[0].instance_type
}

## ==>> Instaces Region:
output "RegoinName" {
  value = data.aws_region.current
}


output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}

#output "public_fqdn" {
#  value = aws_instance.my_win.public_dns
#}

#output "public_ip" {
#  value = aws_instance.my_win.public_ip
#}



output "instance_ip_ama" {
  value = aws_instance.my_amazon.public_ip
}

output "instance_ip_ubuntu" {
  value = aws_eip.my_static_ip.public_ip
}

output "instance_ip_win" {
  value = aws_instance.my_win[0].public_ip
}
