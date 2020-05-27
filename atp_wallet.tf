resource "random_string" "wallet_password" {
  length  = 16
  special = true
}

data "oci_database_autonomous_database_wallet" "FoggyKitchen_ATP_database_wallet" {
  autonomous_database_id = oci_database_autonomous_database.FoggyKitchenATPdatabase.id
  password               = random_string.wallet_password.result
  base64_encode_content  = "true"
}

resource "local_file" "FoggyKitchen_ATP_database_wallet_file" {
  content_base64  = data.oci_database_autonomous_database_wallet.FoggyKitchen_ATP_database_wallet.content
  filename = var.FoggyKitchen_ATP_tde_wallet_zip_file
}

output "wallet_password" {
  value = [random_string.wallet_password.result]
}
