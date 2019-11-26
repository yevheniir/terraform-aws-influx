# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# export AWS_ACCESS_KEY_ID=
# export AWS_SECRET_ACCESS_KEY=

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "license_key" {
  description = "The key of your InfluxDB Enterprise license. This should not be set in plain-text and can be passed in as an env var or from a secrets management tool."
  type        = string
  default     = "7563048b-021b-4ddf-b856-6f4da2809bc2"
}

variable "shared_secret" {
  description = "A long pass phrase that will be used to sign tokens for intra-cluster communication on data nodes. This should not be set in plain-text and can be passed in as an env var or from a secrets management tool."
  type        = string
  default     = "influx_cluster_shared_secret"
}

variable "telegraf_ami_id" {
  description = "The ID of the Telegraf AMI to run in the cluster. This should be an AMI built from the Packer template under examples/telegraf-ami/influxdb.json."
  type        = string
  default     = "ami-03e8e10c50f9a07e8"
}

variable "influxdb_ami_id" {
  description = "The ID of the InfluxDB AMI to run in the cluster. This should be an AMI built from the Packer template under examples/influxdb-ami/influxdb.json."
  type        = string
  default     = "ami-000f3593ee4b24c96"
}

variable "chronograf_ami_id" {
  description = "The ID of the Chronograf AMI to run in the cluster. This should be an AMI built from the Packer template under examples/chronograf-ami/influxdb.json."
  type        = string
  default     = "ami-0b49bc2421eecd2dd"
}

variable "kapacitor_ami_id" {
  description = "The ID of the Kapacitor AMI to run in the cluster. This should be an AMI built from the Packer template under examples/kapacitor-ami/influxdb.json."
  type        = string
  default     = "ami-0ee50881d9726becb"
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

variable "app_server_name" {
  description = "The Name for the app server instance"
  type        = string
  default     = "tick-app-server"
}

variable "telegraf_database" {
  description = "The name of the InfluxDB database Telegraf writes metrics to"
  type        = string
  default     = "telegraf"
}

variable "influxdb_api_port" {
  description = "The HTTP API port the Data nodes listen on for external communication."
  type        = string
  default     = "8086"
}

variable "influxdb_udp_port" {
  description = "The UDP port the Data nodes listen on for external communication."
  type        = string
  default     = "8089"
}

variable "influxdb_tcp_port" {
  description = "The TCP port the Data nodes listen on for external communication."
  type        = string
  default     = "8094"
}

variable "chronograf_host" {
  description = "The host Chronograf listens on."
  type        = string
  default     = "0.0.0.0"
}

variable "chronograf_http_port" {
  description = "The HTTP port Chronograf listens on for external communication."
  type        = string
  default     = "8888"
}

variable "kapacitor_host" {
  description = "The host Kapacitor listens on."
  type        = string
  default     = "0.0.0.0"
}

variable "kapacitor_http_port" {
  description = "The HTTP port Kapacitor listens on for external communication."
  type        = string
  default     = "9092"
}

variable "influxdb_meta_nodes_cluster_name" {
  description = "What to name the InfluxDB meta nodes cluster and all of its associated resources"
  type        = string
  default     = "influxdb-cluster-meta"
}

variable "influxdb_data_nodes_cluster_name" {
  description = "What to name the InfluxDB data nodes cluster and all of its associated resources"
  type        = string
  default     = "influxdb-cluster-data"
}

variable "chronograf_server_name" {
  description = "What to name the Chronograf server and all of its associated resources"
  type        = string
  default     = "chronograf-server"
}

variable "kapacitor_server_name" {
  description = "What to name the Kapacitor server and all of its associated resources"
  type        = string
  default     = "kapacitor-server"
}

variable "ssh_key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster. Set to an empty string to not associate a Key Pair."
  type        = string
  default     = "SPG team key"
}

variable "meta_volume_device_name" {
  description = "The device name to use for the EBS Volume used for the meta directory on InfluxDB meta nodes."
  type        = string
  default     = "/dev/xvdh"
}

variable "meta_volume_mount_point" {
  description = "The mount point (folder path) to use for the EBS Volume used for the meta directory on InfluxDB meta nodes."
  type        = string
  default     = "/influxdb-meta"
}

variable "data_volume_device_name" {
  description = "The device name to use for the EBS Volume used for the meta, data, wal and hh directories on InfluxDB nodes."
  type        = string
  default     = "/dev/sdf"
}

variable "data_volume_mount_point" {
  description = "The mount point (folder path) to use for the EBS Volume used for the meta, data, wal and hh directories on InfluxDB data nodes."
  type        = string
  default     = "/influxdb-data"
}

variable "influxdb_volume_owner" {
  description = "The OS user who should be made the owner of mount points."
  type        = string
  default     = "influxdb"
}

variable "kapacitor_volume_device_name" {
  description = "The device name to use for the EBS Volume used for the Kapacitor storage directory."
  type        = string
  default     = "/dev/sdf"
}

variable "kapacitor_volume_mount_point" {
  description = "The mount point (folder path) to use for the EBS Volume used for the Kapacitor storage directory."
  type        = string
  default     = "/kapacitor"
}

variable "kapacitor_volume_owner" {
  description = "The OS user who should be made the owner of mount points."
  type        = string
  default     = "kapacitor"
}
