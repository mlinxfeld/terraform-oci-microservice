resource "oci_functions_application" "FoggyKitchenFnApp" {
    compartment_id = var.compartment_ocid
    display_name = "FoggyKitchenFnApp"
    subnet_ids = [oci_core_subnet.FoggyKitchenWebSubnet.id]
}

resource "oci_functions_function" "FoggyKitchenUpdateSetupATPFn" {
    depends_on = [null_resource.FoggyKitchenSetupATPFnPush2OCIR]
    application_id = oci_functions_application.FoggyKitchenFnApp.id
    display_name = "SetupATPFn"
    image = "${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/setupatpfn:0.0.1"
    memory_in_mbs = "256" 
}

resource "oci_functions_invoke_function" "FoggyKitchenUpdateSetupATPFnInvoke" {
    depends_on = [oci_database_autonomous_database.FoggyKitchenATPdatabase, oci_functions_function.FoggyKitchenUpdateSetupATPFn]
    function_id = oci_functions_function.FoggyKitchenUpdateSetupATPFn.id
}

resource "oci_functions_function" "FoggyKitchenUpdateCustomersFn" {
    depends_on = [null_resource.FoggyKitchenCustomerFnPush2OCIR, oci_functions_function.FoggyKitchenUpdateSetupATPFn]
    application_id = oci_functions_application.FoggyKitchenFnApp.id
    display_name = "CustomersFn"
    image = "${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/customersfn:0.0.1"
    memory_in_mbs = "256" 
}

