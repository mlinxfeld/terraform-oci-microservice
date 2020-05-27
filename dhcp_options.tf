resource "oci_core_dhcp_options" "FoggyKitchenDhcpOptions1" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
  display_name = "FoggyKitchenDHCPOptions1"

  // required
  options {
    type = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  // optional
  options {
    type = "SearchDomain"
    search_domain_names = [ "foggykitchen.com" ]
  }
}
