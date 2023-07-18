variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    # Ubuntu 20.04
    us-east-1 = "ami-0261755bbcb8c4a84"
    us-east-2 = "ami-0430580de6244e02e"
  }
}

variable "PRIV_KEY_PATH" {
  default = "tf-key"
}

variable "PUB_KEY_PATH" {
  default = "tf-key.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "MYIP" {
  default = ""
}

variable "rmquser" {}

variable "rmqpass" {}

variable "dbname" {}

variable "dbuser" {}

variable "dbpass" {}

variable "instance_count" {
  default = "1"
}

variable "VPC_NAME" {
  default = "tfProjectVpc"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "ZONE3" {
  default = "us-east-1c"
}

variable "VPC_CIDR" {
  default = "172.21.0.0/16"
}

variable "PUB_subnet1_CIDR" {
  default = "172.21.1.0/24"
}

variable "PUB_subnet2_CIDR" {
  default = "172.21.2.0/24"
}

variable "PUB_subnet3_CIDR" {
  default = "172.21.3.0/24"
}

variable "PRIV_subnet1_CIDR" {
  default = "172.21.4.0/24"
}

variable "PRIV_subnet2_CIDR" {
  default = "172.21.5.0/24"
}

variable "PRIV_subnet3_CIDR" {
  default = "172.21.6.0/24"
}
