resource "oci_identity_policy" "FoggyKitchenManageAPIGWFamilyPolicy" {
  name = "FoggyKitchenManageAPIGWFamilyPolicy"
  description = "FoggyKitchenManageAPIGWFamilyPolicy"
  compartment_id = var.compartment_ocid
  statements = ["Allow group Administrators to manage api-gateway-family in compartment id ${var.compartment_ocid}"]
}

resource "oci_identity_policy" "FoggyKitchenManageVCNFamilyPolicy" {
  name = "FoggyKitchenManageVCNFamilyPolicy"
  description = "FoggyKitchenManageVCNFamilyPolicy"
  compartment_id = var.compartment_ocid
  statements = ["Allow group Administrators to manage virtual-network-family in compartment id ${var.compartment_ocid}"]
}

resource "oci_identity_policy" "FoggyKitchenUseFnFamilyPolicy" {
  name = "FoggyKitchenUseFnFamilyPolicy"
  description = "FoggyKitchenUseFnFamilyPolicy"
  compartment_id = var.compartment_ocid
  statements = ["Allow group Administrators to use functions-family in compartment id ${var.compartment_ocid}"]
}


resource "oci_identity_policy" "FoggyKitchenAnyUserUseFnPolicy" {
  name = "FoggyKitchenAnyUserUseFnPolicy"
  description = "FoggyKitchenAnyUserUseFnPolicy"
  compartment_id = var.compartment_ocid
  statements = ["ALLOW any-user to use functions-family in compartment id ${var.compartment_ocid} where ALL { request.principal.type= 'ApiGateway' , request.resource.compartment.id = '${var.compartment_ocid}'}"]
}