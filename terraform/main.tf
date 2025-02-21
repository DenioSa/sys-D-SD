terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


provider "yandex" {
  #token     = "y0__xC71v0fGMHdEyCcpNaqEvTUJYyg1i_fQUrNEEc2VTiIHmet"
  cloud_id  = "b1gcvg80q0ptf53up7tv"
  folder_id = "b1g1resobkrlnebb3l3p"
  service_account_key_file = file("~/key.json")
}
