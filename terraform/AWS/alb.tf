resource "aws_alb" "main" {
  name            = "${var.ecs_cluster}-lb"
  subnets         = aws_subnet.pub_subnet.*.id
  security_groups = [aws_security_group.lb_sg.id]
}

resource "aws_alb_target_group" "api_task" {
  name        = "${var.ecs_cluster}-api-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  // target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/healthcheck/"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_target_group" "nginx_task" {
  name        = "${var.ecs_cluster}-nginx-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  // target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

# Route default traffic to nginx
resource "aws_alb_listener" "ingress" {
  load_balancer_arn = aws_alb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.nginx_task.id
    type             = "forward"
  }
}


resource "aws_alb_listener_rule" "api" {
  listener_arn = aws_alb_listener.ingress.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.api_task.id
  }

  condition {
    path_pattern {
      values = ["/api/*", "/healthcheck/"]
    }
  }
}
