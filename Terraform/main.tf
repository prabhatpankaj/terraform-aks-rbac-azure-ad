provider "azurerm" {
    version = "~>1.5"
}

terraform {
    backend "azurerm" {
    }
}

module "rbac" {
    source = "./rbac"
}

module "kubernetes" {
  source = "./kubernetes"
  public_ssh_key_path = "C:/Users/siim/OneDrive - GT Tarkvara/Passwords/SSH Keys/GT SSH Key/id_rsa_gt.pub"
  client_id = "${module.rbac.client_application_id}"
  client_secret = "${module.rbac.client_application_secret}"
  rbac_server_app_id = "${module.rbac.server_application_id}"
  rbac_server_app_secret = "${module.rbac.server_application_secret}"
  rbac_client_app_id = "${module.rbac.client_application_id}"
}

output "kube_admin_config_raw" {
    value = "${module.kubernetes.kube_admin_config_raw}"
}

output "kube_config_raw" {
    value = "${module.kubernetes.kube_config_raw}"
}