######## Создание виртуальных машин ######## 


### WS-1

resource "yandex_compute_instance" "ws-1" {
  name                      = "wserver-1"
  hostname                  = "webserver-1"
  zone                      = "ru-central1-a"
  allow_stopping_for_update = true
  

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = "${yandex_compute_disk.disk-ws-1.id}"
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet1.id
    dns_record {
      fqdn = "ws-1.srv."
    ttl = 300
    }
    security_group_ids = [yandex_vpc_security_group.internal.id]
    ip_address         = "10.128.1.3"
  }
  

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
  scheduling_policy {  
    preemptible = true
  }
}



### WS-2


resource "yandex_compute_instance" "ws-2" {
  name                      = "wserver-2"
  hostname                  = "webserver-2"
  zone                      = "ru-central1-b"
  allow_stopping_for_update = true
 
  

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = "${yandex_compute_disk.disk-ws-2.id}"
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet2.id
    dns_record {
      fqdn = "ws-2.srv."
    ttl = 300
    }
    security_group_ids = [yandex_vpc_security_group.internal.id]
    ip_address         = "10.129.1.3"
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
  scheduling_policy {  
    preemptible = true
  }
}


###########################################################################



### Bastion


resource "yandex_compute_instance" "ws-b" {
  name                      = "ws-bastion"
  hostname                  = "bastion"
  zone                      = "ru-central1-b" 
  allow_stopping_for_update = true
  

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    disk_id = "${yandex_compute_disk.disk-ws-b.id}"
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
	dns_record {
      fqdn = "ws-b.srv."
    ttl = 300
    }
    nat                = true
    security_group_ids = [yandex_vpc_security_group.internal.id, yandex_vpc_security_group.public-bastion.id]
    ip_address         = "10.129.4.3"
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }

  scheduling_policy {  
    preemptible = true
  }
}



### Zabbix


resource "yandex_compute_instance" "ws-z" {
  name                      = "ws-zabbix"
  hostname                  = "zabbix"
  zone                      = "ru-central1-b"
  allow_stopping_for_update = true


  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    disk_id = "${yandex_compute_disk.disk-ws-z.id}"
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
	dns_record {
      fqdn = "ws-z.srv."
    ttl = 300
    }
    nat                = true
    security_group_ids = [yandex_vpc_security_group.internal.id, yandex_vpc_security_group.public-zabbix.id]
    ip_address         = "10.129.4.4"
    
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }

  scheduling_policy {  
    preemptible = true
  }
}


### Elastic


resource "yandex_compute_instance" "ws-el" {
  name                      = "ws-elastic"
  hostname                  = "elastic"
  zone                      = "ru-central1-b"
  allow_stopping_for_update = true
 

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    disk_id = "${yandex_compute_disk.disk-ws-el.id}"
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private.id
	dns_record {
      fqdn = "ws-el.srv."
    ttl = 300
    }
    security_group_ids = [yandex_vpc_security_group.internal.id]
    ip_address         = "10.129.3.4"
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }

  scheduling_policy {  
    preemptible = true
  }
}



### Kibana


resource "yandex_compute_instance" "ws-k" {
  name                      = "ws-kibana"
  hostname                  = "kibana"
  zone                      = "ru-central1-b"
  allow_stopping_for_update = true


  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    disk_id = "${yandex_compute_disk.disk-ws-k.id}"
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
	dns_record {
      fqdn = "ws-k.srv."
    ttl = 300
    }
    nat                = true
    security_group_ids = [yandex_vpc_security_group.internal.id, yandex_vpc_security_group.public-kibana.id]
    ip_address         = "10.129.4.5"
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }

  scheduling_policy {  
    preemptible = true
  }
}
