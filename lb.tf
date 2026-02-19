resource "aws_lb_listener_rule" "domain" {
  listener_arn = var.https_listener_arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service.arn
  }

  condition {
    host_header {
      values = [local.service_domain]
    }
  }
}