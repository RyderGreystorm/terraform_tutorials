variable "REGION1" {
  description = "AWS region Main region"
  default     = "us-east-1"
}

variable "ZONE1" {
  description = "Resource zone"
  default     = "us-east-1a"
}

variable "AMIS" {
  description = "AMIs from all regions"
  default = {
    us-east-1 = "ami-0ebfd941bbafe70c6"
    us-east-2 = "ami-003932de22c285676"
  }
}

variable "SG-ID" {
  description = "Security Group of REGION 1"
  default     = "sg-04c5a4dc30d6cf4fc"
}

variable "USER" {
  description = "Region1 user"
  default     = "ec2-user"
}