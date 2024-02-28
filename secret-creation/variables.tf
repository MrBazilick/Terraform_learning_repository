# secret name, need to change after each apply/destroy
variable "name" {
  description = "secret name"
  type        = string
  default     = "learn_secret01"
}