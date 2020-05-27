resource "oci_core_nat_gateway" "FoggyKitchenNATGateway" {
    compartment_id = var.compartment_ocid
    display_name = "FoggyKitchenNATGateway"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}
