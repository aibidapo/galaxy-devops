
data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.4.20240429.0-kernel-6.1-x86_64"]
  }
}

resource "aws_instance" "demo-server" {
  ami           = data.aws_ami.server_ami.id
  instance_type = var.instance_type
  key_name      = var.key_pair
  security_groups = ["demo-sg"]

  # vpc_security_group_ids = [aws_security_group.demo-sg.id]
  tags = {
    Name = "Demo-Server"
  }
}

