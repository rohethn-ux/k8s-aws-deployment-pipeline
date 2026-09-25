data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "telemetry_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.telemetry_sg.id]

  user_data = <<-USERDATA
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              docker run -d -p ${var.app_port}:${var.app_port} your-dockerhub-username/telemetry-api:v1
              USERDATA

  tags = {
    Name = "telemetry-api-server"
  }
}

output "instance_public_ip" {
  description = "Public IP of the telemetry API server"
  value       = aws_instance.telemetry_server.public_ip
}

output "app_url" {
  description = "URL to access the telemetry API once running"
  value       = "http://${aws_instance.telemetry_server.public_ip}:${var.app_port}/api/v1/telemetry/status"
}
