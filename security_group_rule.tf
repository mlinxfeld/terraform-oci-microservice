# Rules related to FoggyKitchenATPSecurityGroup

# EGRESS

resource "oci_core_network_security_group_security_rule" "FoggyKitchenATPSecurityEgressGroupRule" {
    network_security_group_id = oci_core_network_security_group.FoggyKitchenATPSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = var.VCN-CIDR
    destination_type = "CIDR_BLOCK"
}

# INGRESS

resource "oci_core_network_security_group_security_rule" "FoggyKitchenATPSecurityIngressGroupRules" {
    network_security_group_id = oci_core_network_security_group.FoggyKitchenATPSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = var.VCN-CIDR
    source_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = 1522
            min = 1522
        }
    }
}

