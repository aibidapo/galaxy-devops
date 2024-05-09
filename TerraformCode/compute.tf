
data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "demo-server" {
  ami             = data.aws_ami.server_ami.id
  instance_type   = var.instance_type
  key_name        = var.key_pair

  vpc_security_group_ids = [aws_security_group.demo-sg.id]
#   security_groups = ["demo-sg"]

  subnet_id = aws_subnet.galaxy-public-subnet-01.id

  for_each = toset(["Jenkins-master", "Build-slave", "Ansible-server"])

  # vpc_security_group_ids = [aws_security_group.demo-sg.id]
  tags = {
    Name = "${each.key}"
  }
}

