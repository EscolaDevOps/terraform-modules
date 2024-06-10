provider "google" {
  project = var.projeto
  region  = var.regiao
  zone    = var.zona
}

resource "google_compute_disk" "disco-boot" {
  name = "${var.nome_vm}-boot-disk"
  size = var.tamanho_disco_boot
  type = var.tipo_disco_boot
  image = coalesce(var.sistema_operacional_imagem, 
    join("", data.google_compute_image.imagem_recente_custom[*].self_link),
    join("", data.google_compute_image.imagem_recente_windows[*].self_link),
    join("", data.google_compute_image.imagem_recente_ubuntu[*].self_link),
    join("", data.google_compute_image.imagem_recente_centos[*].self_link),
    join("", data.google_compute_image.imagem_recente_rhel[*].self_link),
    join("", data.google_compute_image.imagem_recente_debian[*].self_link),
    join("", data.google_compute_image.imagem_recente_rocky[*].self_link),
    join("", data.google_compute_image.imagem_recente_suse[*].self_link))

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
    network_ip = var.ip_privado_fixo

    dynamic "access_config" {
      for_each = var.ip_publico ? [1] : []
      content {
        nat_ip = var.ip_publico_fixo
      }
    }
  }

  metadata_startup_script = !local.so_windows && !local.so_desconhecido && length(trimspace(var.script_boot)) > 0 ? file("${path.root}/${var.script_boot}") : null

  metadata = {
    windows-startup-script-ps1    = local.so_windows && length(trimspace(var.script_boot)) > 0 ? file("${path.root}/${var.script_boot}") : null
    sysprep-specialize-script-ps1 = local.so_windows && length(trimspace(var.script_sysprep)) > 0 ? file("${path.root}/${var.script_sysprep}") : null
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
    precondition {
      condition     = length(trimspace(var.sistema_operacional)) > 0 || length(trimspace(var.sistema_operacional_imagem)) > 0
      error_message = "A variável 'sistema_operacional_imagem' não pode ser vazia quando a variável 'sistema_operacional' está vazia."
    }
  }
}
