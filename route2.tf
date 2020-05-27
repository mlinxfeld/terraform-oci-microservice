resource "oci_core_route_table" "FoggyKitchenRouteTableViaNAT" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
    display_name = "FoggyKitchenRouteTableViaNAT"
    route_rules {
        destination = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
        network_entity_id = oci_core_nat_gateway.FoggyKitchenNATGateway.id
    }
}

