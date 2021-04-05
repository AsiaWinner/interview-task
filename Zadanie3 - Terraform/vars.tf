variable "instance_type" {
  default = "t2.small"
  type    = string
}

variable "region" {
  default = "eu-central-1"
  type    = string
}

variable "az_list" {
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  type    = list(any)
}
