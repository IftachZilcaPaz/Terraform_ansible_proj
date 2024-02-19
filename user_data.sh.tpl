#!/bin/bash
sudo apt update
sudo apt install apache2 -y

cat <<EOF > /var/www/html/index.html
<html>
<h2>Build by Power of Terraform </h2><br>
Owner ${f_name} ${l_name} <br>

%{ for x in names ~}
Hello to ${x} from ${f_name}<br>
%{ endfor ~}

<p>
Haleluya <br>

</html>
EOF

sudo systemctl start apache2
#chkconfig httpd on

