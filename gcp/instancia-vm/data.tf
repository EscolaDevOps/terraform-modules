data "google_compute_image" "imagem_recente_windows" {
  count       = local.so_windows && !local.use_imagem_so ? 1 : 0
  family      = var.sistema_operacional
  project     = "windows-cloud"
  most_recent = true
}

data "google_compute_image" "imagem_recente_ubuntu" {
  count       = local.so_ubuntu && !local.use_imagem_so ? 1 : 0
  family      = var.sistema_operacional
  project     = "ubuntu-os-cloud"
  most_recent = true
}

data "google_compute_image" "imagem_recente_centos" {
  count       = local.so_centos && !local.use_imagem_so ? 1 : 0
  family      = var.sistema_operacional
  project     = "centos-cloud"
  most_recent = true
}

data "google_compute_image" "imagem_recente_rhel" {
  count       = local.so_rhel && !local.use_imagem_so ? 1 : 0
  family      = var.sistema_operacional
  project     = "rhel-cloud"
  most_recent = true
}

data "google_compute_image" "imagem_recente_debian" {
  count       = local.so_debian && !local.use_imagem_so ? 1 : 0
  family      = var.sistema_operacional
  project     = "debian-cloud"
  most_recent = true
}

data "google_compute_image" "imagem_recente_rocky" {
  count       = local.so_rocky && !local.use_imagem_so ? 1 : 0
  family      = var.sistema_operacional
  project     = "rocky-linux-cloud"
  most_recent = true
}

data "google_compute_image" "imagem_recente_suse" {
  count       = local.so_suse && !local.use_imagem_so ? 1 : 0
  family      = var.sistema_operacional
  project     = "suse-byos-cloud"
  most_recent = true
}

data "google_compute_image" "imagem_recente_custom" {
  count       = local.so_desconhecido && !local.use_imagem_so ? 1 : 0
  family      = var.sistema_operacional
  project     = var.sistema_operacional_projeto
  most_recent = true
}

