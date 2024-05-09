/*
# This code works perfectly fine!

resource "random_id" "ai_devops_prod_node_id" {
  byte_length = 2
  count       = var.main_instance_count
}

resource "aws_instance" "ai_devops_prod_main" {
  for_each = toset([for i in range(var.main_instance_count) : tostring(i)])

  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.demo-sg.id]

  subnet_id = aws_subnet.galaxy-public-subnet-01.id
  # Remove the problematic line "subnet_id"
  
  tags = {
    Name = "ai-devops-main-${each.key}"
  }

  provisioner "local-exec" {
    command = "printf '\n${self.public_ip}' >> aws_hosts"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "sed -i '/^[0-9]/d' aws_hosts"
  }
}

*/