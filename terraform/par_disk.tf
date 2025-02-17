resource "yandex_compute_disk" "disk-ws-1" {
  name     = "disk-wserver-1"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  image_id = "fd8epq5qp2v73a23oir4"
  size     = 10
  
}

resource "yandex_compute_disk" "disk-ws-2" {
  name     = "disk-wserver-2"
  type     = "network-hdd"
  zone     = "ru-central1-b"
  image_id = "fd8epq5qp2v73a23oir4"
  size     = 10

}

resource "yandex_compute_disk" "disk-ws-b" {
  name     = "disk-ws-bastion"
  type     = "network-hdd"
  zone     = "ru-central1-b"
  image_id = "fd8epq5qp2v73a23oir4"
  size     = 10
  
}

resource "yandex_compute_disk" "disk-ws-z" {
  name     = "disk-wsz"
  type     = "network-hdd"
  zone     = "ru-central1-b"
  image_id = "fd8epq5qp2v73a23oir4"
  size     = 10
  
}

resource "yandex_compute_disk" "disk-ws-el" {
  name     = "disk-wsel"
  type     = "network-hdd"
  zone     = "ru-central1-b"
  image_id = "fd8epq5qp2v73a23oir4"
  size     = 10
  
}

resource "yandex_compute_disk" "disk-ws-k" {
  name     = "disk-wsk"
  type     = "network-hdd"
  zone     = "ru-central1-b"
  image_id = "fd8epq5qp2v73a23oir4"
  size     = 10
  
}