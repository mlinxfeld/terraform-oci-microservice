resource "oci_core_network_security_group" "FoggyKitchenWebSecurityGroup" {
    compartment_id = var.compartment_ocid
    display_name = "FoggyKitchenWebSecurityGroup"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}

resource "oci_core_network_security_group" "FoggyKitchenSSHSecurityGroup" {
    compartment_id = var.compartment_ocid
    display_name = "FoggyKitchenSSHSecurityGroup"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}

resource "oci_core_network_security_group" "FoggyKitchenATPSecurityGroup" {
    compartment_id = var.compartment_ocid
    display_name = "FoggyKitchenATPSecurityGroup"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}