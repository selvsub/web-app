locals {
  ec2_user_data = templatefile("../../docker-compose.yaml", {})
}

resource "aws_launch_template" "app" {
  name_prefix   = "app-"
  image_id      = "ami-12345678"  # Replace with actual AMI ID
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = base64encode(<<EOF
#!/bin/bash
apt update -y
apt install -y docker.io
systemctl start docker
systemctl enable docker
cat <<EOT > /home/ubuntu/docker-compose.yml
${local.ec2_user_data}
EOT
cd /home/ubuntu
docker-compose up -d
EOF
  )
}
resource "aws_autoscaling_group" "app" {
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = var.private_subnets
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}

output "target_group_arn" {
  value = aws_autoscaling_group.app.arn
}
