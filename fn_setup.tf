resource "null_resource" "FoggyKitchenFnSetup" {
  depends_on = [oci_functions_application.FoggyKitchenFnApp, oci_database_autonomous_database.FoggyKitchenATPdatabase]

  provisioner "local-exec" {
    command = "echo '${var.ocir_user_password}' |  docker login ${var.ocir_docker_repository} --username ${var.ocir_namespace}/${var.ocir_user_name} --password-stdin"
  }

  #provisioner "local-exec" {
  #   command = "sed -i 's/atp_password/${var.atp_password}/g' functions/CustomersFn/func.py"
  #}

  #provisioner "local-exec" {
  #   command = "sed -i 's/atp_alias/${var.FoggyKitchen_ATP_database_db_name}_medium/g' functions/CustomersFn/func.py"
  #}

  provisioner "local-exec" {
    command = "fn build --verbose"
    working_dir = "functions/CustomersFn"
  }

  provisioner "local-exec" {
    command = "image=$(docker images | grep customersfn | awk -F ' ' '{print $3}') ; docker tag $image ${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/customersfn:0.0.1"
    working_dir = "functions/CustomersFn"
  }

  provisioner "local-exec" {
    command = "docker push ${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/customersfn:0.0.1"
    working_dir = "functions/CustomersFn"
  }

}