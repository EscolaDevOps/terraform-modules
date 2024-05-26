output "instancia_ip_privado" {
  value       = google_compute_instance.instancia.network_interface[0].network_ip
  description = "IP privado da instancia"
}

output "instancia_ip_publico" {
  value       = var.ip_publico ? google_compute_instance.instancia.network_interface[0].access_config[0].nat_ip : ""
  description = "IP público da instancia"
}

output "instancia_id" {
  value = google_compute_instance.instancia.id
  description = "ID da instancia"
}

output "imagem_linux" {
  value       = local.is_linux
  description = "Indica se a imagem é Linux"
}

output "imagem_windows" {
  value       = local.is_windows
  description = "Indica se a imagem é Windows"
}