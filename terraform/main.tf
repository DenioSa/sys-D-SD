terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


provider "yandex" {
  token     = "y0_AgAAAAAD_2s7AATuwQAAAAD9G_otAABFGQDiy5hIZrRbU9f0tXhZ9NdVMw"
  cloud_id  = "b1gcvg80q0ptf53up7tv"
  folder_id = "b1g1resobkrlnebb3l3p"
}
