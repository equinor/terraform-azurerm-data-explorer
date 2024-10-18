# Create data explorer instance(kusto cluster)
resource "azurerm_kusto_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name

  allowed_fqdns                      = var.allowed_fqdns
  allowed_ip_ranges                  = var.allowed_ip_ranges
  double_encryption_enabled          = var.double_encryption_enabled
  auto_stop_enabled                  = var.auto_stop_enabled
  disk_encryption_enabled            = var.disk_encryption_enabled
  streaming_ingestion_enabled        = var.streaming_ingestion_enabled
  public_ip_type                     = var.public_ip_type
  public_network_access_enabled      = var.public_network_access_enabled
  outbound_network_access_restricted = var.outbound_network_access_restricted
  purge_enabled                      = var.purge_enabled
  trusted_external_tenants           = var.trusted_external_tenants
  zones                              = var.zones
  sku {
    name     = var.sku_name
    capacity = var.sku_capacity
  }

  dynamic "language_extensions" {
    for_each = var.language_extensions

    content {
      name  = language_extensions.value.name
      image = language_extensions.value.image
    }
  }

  dynamic "virtual_network_configuration" {
    for_each = var.subnet_id != null ? [1] : []
    content {
      subnet_id                    = var.subnet_id
      engine_public_ip_id          = var.engine_public_ip_id
      data_management_public_ip_id = var.data_management_public_ip_id
    }
  }

  identity {
    type         = length(var.identity_ids) > 0 ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.identity_ids
  }

  optimized_auto_scale {
    minimum_instances = var.minimum_instances
    maximum_instances = var.maximum_instances
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = azurerm_kusto_cluster.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = toset(var.diagnostic_setting_enabled_metrics)
    content {
      category = metric.value
    }
  }
}
