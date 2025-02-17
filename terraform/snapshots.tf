resource "yandex_compute_snapshot_schedule" "snapdipl" {
  name = "snapdipl"
  description    = "Ежедневные снимки в течении 7 дней"
 
    schedule_policy {
    expression = "0 8 * * *"
  }

  retention_period = "168h"

  snapshot_spec {
    description = "retention-snapshot"

  }

 
  disk_ids = [
    
    "${yandex_compute_disk.disk-ws-1.id}",
    "${yandex_compute_disk.disk-ws-2.id}",
    "${yandex_compute_disk.disk-ws-b.id}",
    "${yandex_compute_disk.disk-ws-z.id}",
    "${yandex_compute_disk.disk-ws-el.id}",
    "${yandex_compute_disk.disk-ws-k.id}", 
    ]


  depends_on = [
     yandex_compute_instance.ws-1,
     yandex_compute_instance.ws-2,
     yandex_compute_instance.ws-b,
     yandex_compute_instance.ws-z,
     yandex_compute_instance.ws-el,
     yandex_compute_instance.ws-k
  ]

}