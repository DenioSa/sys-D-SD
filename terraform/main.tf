terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


provider "yandex" {
  #token     = ""
  cloud_id  = ""
  folder_id = ""
  service_account_key_file = file("~/key.json")
}
