resource "oci_core_virtual_network" "FoggyKitchenVCN" {
  cidr_block = var.VCN-CIDR
  dns_label = "FoggyKitchenVCN"
  compartment_id = var.compartment_ocid
  display_name = "FoggyKitchenVCN"
}
