variable "instance_type" {
  type    = string
  default = "t2.small"
  # default = "m5dn.xlarge"
} 

variable "whitelist_ips" {
  type = list(string)
  default = [
    "175.176.71.0/32"
    # TODO: add huawei and essential IP as well
  ]
}


variable "public_key" { }
variable "route_53_zone_id" { default = "Z3RDJFJ3ZSDP7B"}
variable "record_name_base" { default = "portaspace.mojaloop.live"}
# variable "record_name_base" { default = "moja-box.vessels.tech"}
