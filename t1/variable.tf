variable "Aws_Region" {
  description = "regions"
  type        = string
  default     = "tyoe the region"
}

variable "Instances" {
  type = map(object({
    instance_type = string
    root_volume = object({
      type = string
      size = number
    })
    key_name = string
  }))
}