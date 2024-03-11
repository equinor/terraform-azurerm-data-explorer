output "cluster_name" {
  value = azurerm_kusto_cluster.this.name
}

output "cluster_id" {
  value = azurerm_kusto_cluster.this.id
}

output "cluster_identity" {
  value = azurerm_kusto_cluster.this.identity
}
