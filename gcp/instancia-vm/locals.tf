locals {
  is_linux   = !can(regex("(?i)windows", var.imagem))
  is_windows = can(regex("(?i)windows", var.imagem))
}