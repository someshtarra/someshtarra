variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "alb_security_group" { type = string }
variable "ec2_security_group" { type = string }
variable "instance_type" { type = string }
variable "environment" { type = string }
