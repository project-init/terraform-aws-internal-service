resource "aws_security_group" "service" {
  name        = "${var.service_name}-${var.environment}-sg"
  description = "Allow inbound and outbound traffic to ${var.service_name} from the internal ALB in ${var.environment}."
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-${var.environment}-sg"
  }
}

resource "aws_security_group_rule" "service_lb_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.lb_security_group_id
  security_group_id        = aws_security_group.service.id
}

resource "aws_security_group_rule" "service_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.service.id
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}
