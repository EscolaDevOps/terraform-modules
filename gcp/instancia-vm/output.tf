output "instancia_ip_privado" {
  value       = google_compute_instance.instancia.network_interface[0].network_ip
  description = "IP privado da instancia."
}

output "instancia_ip_publico" {
  value       = var.ip_publico ? google_compute_instance.instancia.network_interface[0].access_config[0].nat_ip : ""
  description = "IP público da instancia."
}

output "instancia_id" {
  value       = google_compute_instance.instancia.id
  description = "ID da instancia."
}

output "instancia_imagem" {
  value       = google_compute_disk.disco-boot.image
  description = "Nome da imagem que foi utilizada na criação da instância."
}

output "instancia_self_link" {
  value       = google_compute_instance.instancia.self_link
  description = "URI da instancia criada."
}