locals {
  service_domain = var.service_domain != "" ? "${var.service_domain}.${var.domain}" : "${var.service_name}.${var.domain}"
}