# =========================================================== #
# My Terraform main.tf
#
#
# Made by Iftachzi
# =========================================================== #



#provider "aws" {
#  region = var.regionName
#}

provider "aws" {
    region     = "${var.region}"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
}


##############   ==>> Resources <<==  ##############


resource "aws_instance" "my_ubuntu" {
  availability_zone = data.aws_availability_zones.available.names[1]
  ami = data.aws_ami.latest_ubuntu1.id
  instance_type = var.instance_t2
  user_data_replace_on_change = true
  vpc_security_group_ids = [aws_security_group.my_lin.id]
  key_name  = aws_key_pair.generated_key.key_name
  tags = {
    Name    = "My Ubuntu1 Server"
    Owner   = var.Owner
    Project = "Terraform HomeWork"
  }
  #user_data = templatefile("apache2.tpl", {
  #  instance_details = [
  #      {
  #          name = "my_ubuntu",
  #          ami  = data.aws_ami.latest_ubuntu1.id,
  #          os   = data.aws_ami.latest_ubuntu1.name

#        },
 #       {
  #          ami  = data.aws_ami.latest_windows.id,
   #         name = "Windows",
    #        os   = data.aws_ami.latest_windows.name
#
 #       }
  #  ]
#})
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "my_amazon" {
  availability_zone = data.aws_availability_zones.available.names[1]
  ami = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_t2
  user_data_replace_on_change = true
  vpc_security_group_ids = [aws_security_group.my_lin.id]
  key_name  = aws_key_pair.generated_key.key_name
  tags = {
    Name    = "My redhat Server"
    Owner   = var.Owner
    Project = "Terraform HomeWork"
  }
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "my_win" {
  availability_zone = data.aws_availability_zones.available.names[0]
  count = length(var.inst_name)
  ami = data.aws_ami.latest_windows.id
  instance_type = var.instance_t2
  vpc_security_group_ids = [aws_security_group.my_win.id]
  key_name  = aws_key_pair.generated_key.key_name
  user_data = file("${path.module}/ConfigureRemotingForAnsible.ps1")
  tags = {
    Name    = var.inst_name[0] # > one more option: "server - ${count.index+1}"
    Owner   = var.Owner
    Project = "Terraform HomeWork"
  }

}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_ubuntu.id
#  vpc      = true # Need to add in new AWS Provider version
  tags = {
    Name  = "Web Server EIP"
    Owner = var.Owner
  }
}

resource "aws_default_vpc" "default" {}


resource "aws_security_group" "my_lin" {
  name   = "Dynamic Security Group"
  vpc_id = aws_default_vpc.default.id
  dynamic "ingress" {
      for_each = var.ports
      content {
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "my_win" {
  name        = "Static Security Group"
  vpc_id = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "example_sg"
  }
}



resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name  = "generated-key.pem"
  #key_name   = var.key_name ==> option to generate by myself, need to remove also the comment in variable.tf
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/generated-key.pem"
  
    provisioner "local-exec" {
    command = "chmod 600 ${self.filename}"
  }
}