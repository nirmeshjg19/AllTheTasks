variable "AWS_REGION" {
  default = "ap-south-1"
}


variable "key_name" {
  type    = string
  default = "mongo-key-1"
}


variable "vpc_cidr"{
default = "10.0.0.0/16"
}

variable "public_subnet_cidr"{
default = "10.0.1.0/24"
}

variable "public_subnet_cidr_1"{
default = "10.0.6.0/24"
}

variable "private_subnet_cidr"{
default = "10.0.2.0/24"
}

variable "private_subnet_cidr_1"{
default = "10.0.5.0/24"
}

variable "protected_subnet_cidr"{
default = "10.0.3.0/24"
}

variable "protected_subnet_cidr_1"{
default = "10.0.4.0/24"
}

variable "def_cidr"{
default = "0.0.0.0/0"
}



