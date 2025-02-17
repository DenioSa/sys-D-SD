
##### Вывод по созданным серверам #####

output "internal_ip_address_ws-1" {
  value = yandex_compute_instance.ws-1.network_interface.0.ip_address
}

output "FQDN_ws-1" {
  value = yandex_compute_instance.ws-1.fqdn
}

output "internal_ip_address_ws-2" {
  value = yandex_compute_instance.ws-2.network_interface.0.ip_address
}

output "FQDN_ws-2" {
  value = yandex_compute_instance.ws-2.fqdn
}




output "external_ip_address_ws-b" {
  value = yandex_compute_instance.ws-b.network_interface.0.nat_ip_address
}

output "internal_ip_address_ws-b" {
  value = yandex_compute_instance.ws-b.network_interface.0.ip_address
}

output "FQDN_ws-b" {
  value = yandex_compute_instance.ws-b.fqdn
}

output "external_ip_address_ws-z" {
  value = yandex_compute_instance.ws-z.network_interface.0.nat_ip_address
}

output "internal_ip_address_ws-z" {
  value = yandex_compute_instance.ws-z.network_interface.0.ip_address
}

output "FQDN_ws-z" {
  value = yandex_compute_instance.ws-z.fqdn
}

output "external_ip_address_ws-k" {
  value = yandex_compute_instance.ws-k.network_interface.0.nat_ip_address
}

output "internal_ip_address_ws-k" {
  value = yandex_compute_instance.ws-k.network_interface.0.ip_address
}

output "FQDN_ws-k" {
  value = yandex_compute_instance.ws-k.fqdn
}

output "internal_ip_address_ws-el" {
  value = yandex_compute_instance.ws-el.network_interface.0.ip_address
}

output "FQDN_ws-el" {
  value = yandex_compute_instance.ws-el.fqdn
}

output "external_ip_address_load_balancer" {
  value = yandex_alb_load_balancer.load_balancer.listener.0.endpoint.0.address.0.external_ipv4_address
}



########################################################################