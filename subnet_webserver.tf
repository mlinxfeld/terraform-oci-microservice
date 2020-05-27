resource "oci_core_subnet" "FoggyKitchenWebSubnet" {
  cidr_block = "10.0.1.0/24"
  display_name = "FoggyKitchenWebSubnet"
  dns_label = "fkN1"
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
  dhcp_options_id = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
}


