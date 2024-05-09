variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_pair" {
  type    = string
  default = "galaxy-deployer-key"
}

variable "ingress_ports" {
  description = "List of ingress ports"
  type        = list(number)
  default     = [22, 80, 443, 8080]
}

