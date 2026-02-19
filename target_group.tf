resource "aws_lb_target_group" "service" {
  name                 = "${var.service_name}-${var.environment}-tg"
  target_type          = "ip"
  port                 = 80
  protocol             = "HTTP"
  protocol_version     = var.protocol_version
  deregistration_delay = 30
  vpc_id               = var.vpc_id

  health_check {
    port                = var.container_port
    healthy_threshold   = 2
    interval            = 5
    timeout             = 2
    protocol            = "HTTP"
    matcher             = 0
    unhealthy_threshold = 2
    path                = var.health_check_path
  }
}
