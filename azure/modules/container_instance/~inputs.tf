variable "common" {}
variable "key" {}
variable "storage_account" {}
variable "image" {}
variable "cpu_cores" {}
variable "mem_gb" {}
variable "share_gb" {}
variable "share_tier" {
  default = "TransactionOptimized"
}