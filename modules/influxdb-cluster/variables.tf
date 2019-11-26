# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "cluster_name" {
  description = "The name of the InfluxDB cluster (e.g. influxdb-stage). This variable is used to namespace all resources created by this module."
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to run in this cluster."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 Instances to run for each node in the cluster (e.g. t2.micro)."
  type        = string
}

variable "min_size" {
  description = "The minimum number of nodes to have in the InfluxDB cluster."
  type        = number
}

variable "max_size" {
  description = "The maximum number of nodes to have in the InfluxDB cluster."
  type        = number
}

variable "vpc_id" {
  description = "The ID of the VPC in which to deploy the InfluxDB cluster"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs into which the EC2 Instances should be deployed."
  type        = list(string)
}

variable "user_data" {
  description = "A User Data script to execute while the server is booting."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "ssh_key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster. Set to an empty string to not associate a Key Pair."
  type        = string
  default     = null
}

variable "allowed_ssh_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow SSH connections"
  type        = list(string)
  default     = []
}

variable "allowed_ssh_security_group_ids" {
  description = "A list of security group IDs from which the EC2 Instances will allow SSH connections"
  type        = list(string)
  default     = []
}

variable "allowed_ssh_security_group_ids_num" {
  description = "The number of security group IDs in var.beats_port_security_groups. We should be able to compute this automatically, but due to a Terraform limitation, if there are any dynamic resources in var.allowed_ssh_security_group_ids, then we won't be able to: https://github.com/hashicorp/terraform/pull/11482"
  type        = number
  default     = null
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default."
  type        = string
  default     = "Default"
}

variable "associate_public_ip_address" {
  description = "If set to true, associate a public IP address with each EC2 Instance in the cluster."
  type        = bool
  default     = false
}

variable "spot_price" {
  description = "The maximum hourly price to pay for EC2 Spot Instances."
  type        = string
  default     = null
}

variable "tenancy" {
  description = "The tenancy of the instance. Must be one of: empty string, default, or dedicated. For EC2 Spot Instances only empty string or dedicated can be used."
  type        = string
  default     = null
}

variable "root_volume_ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized."
  type        = bool
  default     = false
}

variable "root_volume_type" {
  description = "The type of volume. Must be one of: standard, gp2, or io1."
  default     = "gp2"
}

variable "root_volume_size" {
  description = "The size, in GB, of the root EBS volume."
  type        = number
  default     = 50
}

variable "root_volume_delete_on_termination" {
  description = "Whether the volume should be destroyed on instance termination."
  type        = bool
  default     = true
}

variable "root_volume_iops" {
  description = "The amount of provisioned IOPS for the root volume. Only used if volume type is io1."
  type        = number
  default     = 0
}

variable "ebs_block_devices" {
  description = "A list of EBS volumes to attach to each EC2 Instance. Each item in the list should be an object with the keys 'device_name', 'volume_type', 'volume_size', 'iops', 'delete_on_termination', and 'encrypted', as defined here: https://www.terraform.io/docs/providers/aws/r/launch_configuration.html#block-devices. We recommend using one EBS Volume for each instance."
  # We can't narrow the type down more than "any" because if we use list(object(...)), then all the fields in the
  # object will be required (whereas some, such as encrypted, should be optional), and if we use list(map(...)), all
  # the values in the map must be of the same type, whereas we need some to be strings, some to be bools, and some to
  # be ints. So, we have to fall back to just any ugly "any."
  type    = any
  default = []
  # Example:
  #
  # default = [
  #   {
  #     device_name = "/dev/xvdh"
  #     volume_type = "gp2"
  #     volume_size = 300
  #     encrypted   = true
  #   }
  # ]
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  default     = "10m"
}

variable "health_check_type" {
  description = "Controls how health checking is done. Must be one of EC2 or ELB."
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Time, in seconds, after instance comes into service before checking health."
  type        = number
  default     = 600
}

variable "instance_profile_path" {
  description = "Path in which to create the IAM instance profile."
  type        = string
  default     = "/"
}

variable "ssh_port" {
  description = "The port used for SSH connections"
  type        = number
  default     = 22
}

variable "tags" {
  description = "List of extra tag blocks added to the autoscaling group configuration. Each element in the list is a map containing keys 'key', 'value', and 'propagate_at_launch' mapped to the respective values."
  type = list(object({
    key                 = string
    value               = string
    propagate_at_launch = bool
  }))
  default = []
  # Example:
  #
  # default = [
  #   {
  #     key                 = "foo"
  #     value               = "bar"
  #     propagate_at_launch = true
  #   }
  # ]
}
