##############   ==>> Variables <<==  ##############

variable "access_key" {
    description = "Access key to AWS console"
}
variable "secret_key" {
    description = "Secret key to AWS console"
}
variable "region" {
    description = "AWS region"
}



variable "Owner" {
  description = "tag owner name"
  default = "iftachzi"
  type = string
}

variable "ports" {
  default = ["80", "443","22"]
  description = "port to and from for SG"
    type = list(string)
}

variable "instance_t2" {
  default = "t2.micro"
  description = "t2 sections of instace type"
  type = string
}

variable "inst_name" {
  default = ["my_win",]
  type = list(string)
}

variable "regionName" {
  default = "us-east-1"
  type = string
  description = "my region"
}

#variable "key_name" {}

#variable "instance_name" {
#  default = "win2019-sa1"
#}

#variable "instance_username" {
#  type = string
#  #default = "winadmin1"
#}

#variable "instance_password" {
#  type = string
#  #default = ""
#}

variable "ingress_rules" {
  description = "A list of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = [
    {
      from_port   = -1,  # ICMP
      to_port     = -1,
      protocol    = "icmp",
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80,  # HTTP
      to_port     = 80,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443, # HTTPS
      to_port     = 443,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 3389, # HTTPS
      to_port     = 3389,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 5985, # HTTPS
      to_port     = 5985,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 5986, # HTTPS
      to_port     = 5986,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22, # HTTPS
      to_port     = 22,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    }
    # Add more rules as needed
  ]
}
#