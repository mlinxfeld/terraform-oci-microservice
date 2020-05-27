resource "oci_database_autonomous_database" "FoggyKitchenATPdatabase" {
  admin_password           = var.atp_password
  compartment_id           = var.compartment_ocid
  cpu_core_count           = var.FoggyKitchen_ATP_database_cpu_core_count
  data_storage_size_in_tbs = var.FoggyKitchen_ATP_database_data_storage_size_in_tbs
  db_name                  = var.FoggyKitchen_ATP_database_db_name
  db_version               = var.FoggyKitchen_ATP_database_db_version
  display_name             = var.FoggyKitchen_ATP_database_display_name
  freeform_tags            = var.FoggyKitchen_ATP_database_freeform_tags
  license_model            = var.FoggyKitchen_ATP_database_license_model
  nsg_ids                  = [oci_core_network_security_group.FoggyKitchenATPSecurityGroup.id]   
  private_endpoint_label   = var.FoggyKitchen_ATP_database_atp_private_endpoint_label
  subnet_id                = oci_core_subnet.FoggyKitchenATPEndpointSubnet.id      
}

data "oci_database_autonomous_databases" "FoggyKitchenATPdatabases" {
  compartment_id = var.compartment_ocid
  display_name = var.FoggyKitchen_ATP_database_display_name
}

output "FoggyKitchen_ATP_database_admin_password" {
   value = var.atp_password
}

output "FoggyKitchen_ATP_databases" {
  value = data.oci_database_autonomous_databases.FoggyKitchenATPdatabases.autonomous_databases
}

output "parallel_connection_string" {
  value = [lookup(oci_database_autonomous_database.FoggyKitchenATPdatabase.connection_strings.0.all_connection_strings, "PARALLEL", "Unavailable")]
}
