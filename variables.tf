variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The log analytics workspace to write logs and metrics to"
  type        = string
}

variable "cluster_name" {
  description = "The name of the Data Explorer cluster"
  type        = string
}

variable "sku_name" {
  description = "The name of the sku fro the cluster. More info: https://learn.microsoft.com/en-us/azure/data-explorer/manage-cluster-choose-sku#select-and-optimize-your-compute-sku"
  type        = string
}

variable "sku_capacity" {
  description = "The node count of specified sku for the cluster"
  type        = number
  default     = 2
}

variable "allowed_fqdns" {
  description = "A list of allowed fqdns for egress from cluster. (if 'outbound_network_access_restricted' is true)"
  type        = set(string)
  default     = null
}

variable "allowed_ip_ranges" {
  description = "A list of allowed ips that can access the cluster. (if 'public_network_access_enabled' is false)"
  type        = set(string)
  default     = null
}

variable "double_encryption_enabled" {
  description = "Enable double encryption on data at rest. When double encryption is enabled, data in the storage account is encrypted twice, using two different algorithms. Can create a performance impact"
  type        = bool
  default     = true
}

variable "auto_stop_enabled" {
  description = "Automatically stop the cluster if it has been inactive(no queries or data ingestion for 5 days). The interval is fixed at 5 days and cannot be changed"
  type        = bool
  default     = true
}

variable "disk_encryption_enabled" {
  description = "Enable disk encryption for data at rest. Can create a performance impact"
  type        = bool
  default     = true
}

variable "streaming_ingestion_enabled" {
  description = "Enable streaming ingestion instead of queued ingestion. More info: https://learn.microsoft.com/en-us/azure/data-explorer/ingest-data-streaming?tabs=azure-portal%2Ccsharp"
  type        = bool
  default     = false
}

variable "public_ip_type" {
  description = "What public ip type should be used"
  type        = string
  default     = "IPv4"
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = true
}

variable "outbound_network_access_restricted" {
  description = "Enable eggress network restrictions"
  type        = bool
  default     = false
}

variable "purge_enabled" {
  description = "Enable purge operations"
  type        = bool
  default     = false
}

variable "language_extensions" {
  description = "A list of language_extensions to enable"
  type = list(object({
    name  = string
    image = string
  }))
  default = []
}

variable "trusted_external_tenants" {
  description = "A list of external tenants that are trusted to access the cluster for data ingress/egress"
  type        = set(string)
  default     = []
}

variable "zones" {
  description = "A List of Availability Zones in which this Kusto Cluster should be located"
  type        = set(string)
  default     = null
}

variable "subnet_id" {
  description = "A subnet id for private network access"
  type        = string
  default     = null
}

variable "engine_public_ip_id" {
  description = "A public ip id for the cluster engine. Required when 'subnet_id' is not null"
  type        = string
  default     = null
}

variable "data_management_public_ip_id" {
  description = "A public ip id for the cluster data managment endpoint. Required when 'subnet_id' is not null"
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "A List of user managed identities"
  type        = set(string)
  default     = []
}

variable "minimum_instances" {
  description = "The minimum number of instances in auto scaling"
  type        = number
  default     = 2
}

variable "maximum_instances" {
  description = "The maximum number of instances in auto scaling"
  type        = number
  default     = 5
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default = [
    "Command",
    "FailedIngestion",
    "IngestionBatching",
    "Journal",
    "Query",
    "SucceededIngestion",
    "TableDetails",
    "TableUsageStatistics"
  ]
}

variable "diagnostic_setting_enabled_metrics" {
  description = "A list of metrics to be enabled for this diagnostic setting."
  type        = list(string)
  default = [
    "AllMetrics"
  ]
}
