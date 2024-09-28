# Locals to compute the naming convention
locals {
  naming_convention = "${var.org}-${var.env}-${var.application}-${var.use_case}"
}
