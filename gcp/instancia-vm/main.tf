provider "google" {
  project = var.projeto
  region  = var.regiao
  zone    = var.zona
}

resource "google_compute_disk" "disco-boot" {
  name  = "${var.nome_vm}-boot-disk"
  size  = var.tamanho_disco_boot
  type  = var.tipo_disco_boot
  image = var.imagem

  lifecycle {
    ignore_changes = [
      name,
      image
    ]
  }
}

resource "google_compute_disk" "disco-adicional" {
  for_each = var.disco_adicional
  name     = "${var.nome_vm}-${each.key}"
  size     = each.value.tamanho
  type     = each.value.tipo
}

resource "google_compute_instance" "instancia" {
  name         = var.nome_vm
  machine_type = var.tipo_vm

  boot_disk {
    source = google_compute_disk.disco-boot.id
  }

  dynamic "attached_disk" {
    for_each = google_compute_disk.disco-adicional
    content {
      source = attached_disk.value.id
    }
  }

  network_interface {
    network    = var.rede
    subnetwork = var.subrede

    dynamic access_config {
      for_each = var.ip_publico ? [1] : []
      content {
      }
    }
  }

  metadata_startup_script = local.is_linux && length(trimspace(var.script_boot)) > 0 ? file("${path.root}/${var.script_boot}") : null

  metadata = {
    windows-startup-script-ps1 = local.is_windows && length(trimspace(var.script_boot)) > 0 ? file("${path.root}/${var.script_boot}") : null
    sysprep-specialize-script-ps1 = local.is_windows && length(trimspace(var.script_sysprep)) > 0 ? file("${path.root}/${var.script_sysprep}") : null
  }

  tags = var.tags_rede

  depends_on = [
    google_compute_disk.disco-boot,
    google_compute_disk.disco-adicional
  ]

  lifecycle {
    ignore_changes = [
      name,
      metadata_startup_script,
      metadata
    ]
  }
}
