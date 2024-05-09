resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "Allow inbound traffic"

  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = iport
    content {
      from_port   = iport.value
      to_port     = iport.value
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

  tags = {
    Name = "demo-sg"
  }
}



