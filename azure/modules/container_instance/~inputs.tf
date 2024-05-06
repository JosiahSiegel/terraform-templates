variable "common" {}
variable "key" {}
variable "storage_account" {}
variable "image" {}
variable "cpu_cores" {}
variable "mem_gb" {}
variable "commands" {
  default = []
}
variable "exec" {
  default = ""
}
variable "repos" {
  default = {}
}
variable "shares" {
  default = {}
}
variable "os_type" {
  default = "Linux"
}