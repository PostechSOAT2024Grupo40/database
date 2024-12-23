variable "vpc_id" {
  type    = string
  default = "vpc-01525f58b2e30df1b"
}

variable "subnets_id" {
  type    = list(string)
  default = ["subnet-0bb9852652d96a262", "subnet-026aa6afec7589bb2"]
}