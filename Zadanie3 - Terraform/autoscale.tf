data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

resource "aws_launch_configuration" "webserver" {
  name_prefix   = "web-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  user_data     = file("userdata.sh")
  security_groups = [
    module.web_server_sg.this_security_group_id,
  ]

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
}

resource "aws_autoscaling_group" "webservers" {
  vpc_zone_identifier = module.vpc.public_subnets
  target_group_arns   = [aws_lb_target_group.servers.arn, ]

  name                      = "webserver"
  max_size                  = "12"
  min_size                  = "3"
  health_check_grace_period = 60
  health_check_type         = "EC2"
  desired_capacity          = 3
  force_delete              = true
  launch_configuration      = aws_launch_configuration.webserver.name

  tag {
    key                 = "Name"
    value               = "Webservers"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale-up" {
  name                   = "instance-scale-up"
  scaling_adjustment     = 3
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.webservers.name
}

resource "aws_autoscaling_policy" "scale-down" {
  name                   = "instance-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.webservers.name
}
