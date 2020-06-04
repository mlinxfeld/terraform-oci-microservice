variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "atp_password" {}
variable "atp_admin_password" {}

variable "atp_admin_user" {
 default = "admin"
}

variable "atp_user" {
 default = "fkuser"
}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "VCNname" {
  default = "VCN"
}

variable "httpx_ports" {
  default = ["80", "443"]
}

variable "FoggyKitchen_ATP_database_cpu_core_count" {
  default = 1
}

variable "FoggyKitchen_ATP_database_data_storage_size_in_tbs" {
  default = 1
}

variable "FoggyKitchen_ATP_database_db_name" {
  default = "fkatpdb5"
}

variable "FoggyKitchen_ATP_database_db_version" {
  default = "18c"
}

variable "FoggyKitchen_ATP_database_defined_tags_value" {
  default = "value"
}

variable "FoggyKitchen_ATP_database_display_name" {
  default = "FoggyKitchenATP"
}

variable "FoggyKitchen_ATP_database_display_clone_name" {
  default = "FoggyKitchenATPClone"
}

variable "FoggyKitchen_ATP_database_display_clone_from_backup_name" {
  default = "FoggyKitchenATPCloneFromBackup"
}

variable "FoggyKitchen_ATP_database_freeform_tags" {
  default = {
    "Owner" = "FoggyKitchen"
  }
}

variable "FoggyKitchen_ATP_database_license_model" {
  default = "LICENSE_INCLUDED"
}

variable "FoggyKitchen_ATP_tde_wallet_zip_file" {
  default = "tde_wallet.zip"
}

variable "FoggyKitchen_ATP_database_atp_private_endpoint_label" {
  default = "FoggyKitchenATPPrivateEndpoint"
}

variable "FoggyKitchen_ATP_database_atp_clone_private_endpoint_label" {
  default = "FoggyKitchenATPClonePrivateEndpoint"
}

variable "FoggyKitchen_ATP_database_atp_clone_from_backup_private_endpoint_label" {
  default = "FoggyKitchenATPCloneFromBackupPrivateEndpoint"
}

variable "ocir_namespace" {
  default = ""
}

variable "ocir_repo_name" {
  default = ""
}

variable "ocir_docker_repository" {
  default = ""
}

variable "ocir_user_name" {
  default = ""
}

variable "ocir_user_password" {
  default = ""
}