#!/bin/bash
sudo apt update
sudo apt install apache2 -y

cat <<EOF > /var/www/html/index.html
<html>
<h2>Build My Homwork with Terraform </h2><br>
<h3>Owner iftachzi</h3> <br>
<br>

I have in this project two instances:<br>
<br>
<br>
%{ for instance in instance_details ~}
name -  ${instance.name}<br>
os - ${instance.os}<br>
ami - ${instance.ami}<br>
<br>
<br>
%{ endfor ~}

<p>
This is my homework <br>

</html>
EOF

sudo systemctl start apache2

