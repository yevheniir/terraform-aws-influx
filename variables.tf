# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------



# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "license_key" {
  description = "The key of your InfluxDB Enterprise license. This should not be set in plain-text and can be passed in as an env var or from a secrets management tool."
  type        = string
  default     = "55fa424d-d24f-403e-94e9-3bdf24bd78ee"
}

variable "shared_secret" {
  description = "A long pass phrase that will be used to sign tokens for intra-cluster communication on data nodes. This should not be set in plain-text and can be passed in as an env var or from a secrets management tool."
  type        = string
  default     = "influx_cluster_shared_secret"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS region in which all resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The ID of the AMI to run in the cluster. This should be an AMI built from the Packer template under examples/influxdb-ami/influxdb.json."
  type        = string
  default     = null
}

variable "influxdb_cluster_name" {
  description = "What to name the InfluxDB meta nodes cluster and all of its associated resources"
  type        = string
  default     = "influxdb-cluster"
}

variable "ssh_key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster. Set to an empty string to not associate a Key Pair."
  type        = string
  default     = "SPG team key"
}

variable "volume_device_name" {
  description = "The device name to use for the EBS Volume used for the meta, data, wal and hh directories on InfluxDB nodes."
  type        = string
  default     = "/dev/xvdh"
}

variable "volume_mount_point" {
  description = "The mount point (folder path) to use for the EBS Volume used for the meta, data, wal and hh directories on InfluxDB data nodes."
  type        = string
  default     = "/influxdb"
}

variable "volume_owner" {
  description = "The OS user who should be made the owner of mount points."
  type        = string
  default     = "influxdb"
}
