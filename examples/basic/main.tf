provider "azurerm" {
  features {}
}


resource "random_id" "example" {
  byte_length = 8
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${random_id.example.hex}"
  location = var.location
}

module "log_analytics" {
  source              = "github.com/equinor/terraform-azurerm-log-analytics?ref=v2.2.0"
  workspace_name      = "log-${random_id.example.hex}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

module "data_explorer" {
  # source = "github.com/equinor/terraform-azurerm-data-explorer?ref=v0.0.0"
  source = "../.."

  cluster_name               = var.cluster_name
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  sku_name                   = "Standard_E2d_v5"
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
