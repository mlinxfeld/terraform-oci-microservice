resource "oci_core_network_security_group" "FoggyKitchenATPSecurityGroup" {
    compartment_id = var.compartment_ocid
    display_name = "FoggyKitchenATPSecurityGroup"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}