resource "aws_iam_server_certificate" "test_cert" {
  name             = "test_cert"
  certificate_body = file("public.pem")
  private_key      = file("private.pem")
}

resource "aws_lb" "web" {
  name               = "loadbalancer"
  internal           = false
  load_balancer_type = "application"

  # https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/outputs.tf
  subnets = module.vpc.public_subnets
  security_groups = [
    module.load_balancer_sg.this_security_group_id,
  ]
}

resource "aws_lb_target_group" "servers" {
  name     = "web-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener#redirect-action
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.web.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_iam_server_certificate.test_cert.arn

  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener#fixed-response-action
  ## TEST SSL WORKED
  # default_action {
  #   type = "fixed-response"

  #   fixed_response {
  #     content_type = "text/plain"
  #     message_body = "Fixed response content"
  #     status_code  = "200"
  #   }
  # }

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.servers.arn
  }
}


