### Создание сети Network

resource "yandex_vpc_network" "network_1" {
  name = "network1"
  }

resource "yandex_vpc_gateway" "nat_gateway" {  
  name = "nat-gateway"                         
  shared_egress_gateway {}                     
  }

resource "yandex_vpc_route_table" "inner-to-nat" {
  network_id = yandex_vpc_network.network_1.id
  
  static_route {
    destination_prefix = "0.0.0.0/0"
    #next_hop_address   = yandex_compute_instance.ws-b.network_interface.0.ip_address
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
    
  }
}

### Создание подсетей Subnet

resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet_1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_1.id
  v4_cidr_blocks = ["10.128.1.0/24"]
  route_table_id = yandex_vpc_route_table.inner-to-nat.id
  }

 
resource "yandex_vpc_subnet" "subnet2" {
  name           = "subnet_2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network_1.id
  v4_cidr_blocks = ["10.129.1.0/24"]
  route_table_id = yandex_vpc_route_table.inner-to-nat.id
  }


resource "yandex_vpc_subnet" "private" {
  name           = "internal-subnet"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network_1.id
  v4_cidr_blocks = ["10.129.3.0/24"]
  route_table_id = yandex_vpc_route_table.inner-to-nat.id
}

resource "yandex_vpc_subnet" "public" {
  name           = "public-subnet"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network_1.id
  v4_cidr_blocks = ["10.129.4.0/24"]  
}


##############################################################


### TargetGroup 

  resource "yandex_alb_target_group" "tg_group" {
  name = "my-tg"

  target {
    ip_address = yandex_compute_instance.ws-1.network_interface.0.ip_address
    subnet_id  = yandex_vpc_subnet.subnet1.id
  }

  target {
    ip_address = yandex_compute_instance.ws-2.network_interface.0.ip_address
    subnet_id  = yandex_vpc_subnet.subnet2.id
  }
}



### BackendGroup

resource "yandex_alb_backend_group" "bk_group" {
  name = "my-bg"

  http_backend {
    name             = "http-backend"
    weight           = 1
    port             = 80
    target_group_ids = [yandex_alb_target_group.tg_group.id]
    load_balancing_config {
      panic_threshold = 90
    }
    healthcheck {
      timeout             = "10s"
      interval            = "2s"
      healthy_threshold   = 10
      unhealthy_threshold = 15
      http_healthcheck {
        path = "/"
      }
    }
  }
}


### HTTP route

resource "yandex_alb_http_router" "http_router" {
  name = "my-router"
}

resource "yandex_alb_virtual_host" "root" {
  name           = "root-virtual-host"
  http_router_id = yandex_alb_http_router.http_router.id
  route {
    name = "root-path"
    http_route {
      http_match {
        path {
          prefix = "/"
        }
      }
      http_route_action {
        backend_group_id = yandex_alb_backend_group.bk_group.id
        timeout          = "3s"
      }
    }
  }
}


### Load7Balancer

resource "yandex_alb_load_balancer" "load_balancer" {
  name               = "my-l7b"
  network_id         = yandex_vpc_network.network_1.id
  security_group_ids = [yandex_vpc_security_group.public-load-balancer.id, yandex_vpc_security_group.internal.id] 

  allocation_policy {
    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.private.id
    }
  }

  listener {
    name = "my-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.http_router.id
      }
    }
  }
}

