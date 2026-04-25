resource "azurerm_resource_group" "new09" {
  for_each = var.newvar
  name     = each.value.name
  location = each.value.location
}

resource "azurerm_storage_account" "mynwstor" {
  for_each                 = var.newvar
  name                     = each.value.storage_name
  resource_group_name      = azurerm_resource_group.new09[each.key].name
  location                 = azurerm_resource_group.new09[each.key].location
  account_tier             = "Standard"
  account_replication_type = "LRS"


}

resource "azurerm_storage_container" "pot6" {
  for_each              = var.newvar
  name                  = each.value.container_name
  storage_account_id    = azurerm_storage_account.mynwstor[each.key].id
  container_access_type = "blob"
}