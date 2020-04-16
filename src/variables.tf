variable "instance_type" {
  type    = string
  # default = "t2.small"
  default = "m5dn.xlarge"
} 

variable "whitelist_ips" {
  type = list(string)
  default = [
    "175.176.71.0/24",
    "110.54.219.0/24"
    # TODO: add huawei and essential IP as well
  ]
}

variable "public_key" { }

# find this value in the route53 console
variable "route_53_zone_id" { default = "Z3RDJFJ3ZSDP7B" }

variable "record_name_base" { default = "portaspace.mojaloop.live" }
