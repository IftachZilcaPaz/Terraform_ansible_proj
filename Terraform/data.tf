##############   ==>> Data <<==  ##############



data "aws_ami" "latest_ubuntu1" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64*"]
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
}


data "aws_ami" "latest_windows" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

}


data "aws_availability_zones" "available" {}

data "aws_ec2_instance_types" "all_instance_types" {}

data "aws_region" "current" {}

#data "template_file" "windows-userdata" {
#    template = <<EOF
#      ＜powershell＞
#      Invoke-WebRequest -Uri https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1 -OutFile ConfigureRemotingForAnsible.ps1
#      powershell -ExecutionPolicy RemoteSigned .\ConfigureRemotingForAnsible.ps1
#      $admin = [ADSI]("WinNT://./administrator, user")
#      $admin.SetPassword("${var.instance_password}")
#      ＜/powershell＞
#    EOF
#}
