resource "oci_core_internet_gateway" "FoggyKitchenInternetGateway" {
    compartment_id = var.compartment_ocid
    display_name = "FoggyKitchenInternetGateway"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}
