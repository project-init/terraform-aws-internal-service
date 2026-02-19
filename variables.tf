########################################################################################################################
### Common
########################################################################################################################

variable "environment" {
  type        = string
  nullable    = false
  description = "The environment to deploy the internal service to."
}

variable "ecs_cluster_arn" {
  type        = string
  description = "The ARN of the ecs cluster to deploy the service on."
}

variable "ecs_cluster_name" {
  type        = string
  description = "The name of the ecs cluster to deploy the service on."
}

variable "service_name" {
  type        = string
  nullable    = false
  description = "The name of the service."
}

########################################################################################################################
### ECS Cluster/Service
########################################################################################################################

variable "subnets" {
  type        = set(string)
  description = "The subnets to deploy the service in to."
}

variable "security_groups" {
  type        = list(string)
  description = "IDs of the extra security groups you want the task to have access to."
}

variable "use_ec2" {
  type        = bool
  default     = false
  description = "Whether to deploy the service on an ec2 backed service or fargate."
}

variable "capacity_providers" {
  default = []
  type = set(object({
    capacity_provider = string
    base              = number
    weight            = number
  }))
  description = "List of capacity providers to use for distributing tasks. Should primarily be used when utilizing ec2 backed ecs."
}

variable "ordered_placement_strategies" {
  default = []
  type = set(object({
    type  = string
    field = string
  }))
  description = "List of ordered placement strategies to use for distributing tasks. Should primarily be used when utilizing ec2 backed ecs."
}

variable "force_new_deployment" {
  type        = bool
  default     = false
  description = "Whether to force a new deployment when updating the ecs service."
}

variable "container_port" {
  default     = 9001
  type        = number
  description = "The port the internal service runs on."
}

variable "health_check_path" {
  type        = string
  default     = "/grpc.health.v1.Health/Check"
  description = "The path for the healthcheck to use. i.e. /grpc.health.v1.Health/Check, /healthcheck, etc..."
}

########################################################################################################################
### ECS Task
########################################################################################################################

variable "environment_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = []
  description = "The environment variables to use for the service."
}

variable "log_level" {
  type        = string
  default     = "info"
  description = "Default value for LOG_LEVEL."

  validation {
    condition     = contains(["debug", "info", "warn", "error"], var.log_level)
    error_message = "Log level must be one of: debug, info, warn, error."
  }
}

variable "log_add_source" {
  type        = bool
  default     = false
  description = "Default value for LOG_ADD_SOURCE."
}

variable "secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default     = []
  description = "The secrets to use for the service."
}

variable "image" {
  type        = string
  nullable    = false
  description = "The docker image to use for the container."
}

variable "desired_count" {
  type        = number
  default     = 0
  description = "Desired count of tasks to run. This is ignored after the first apply."
}

variable "max_capacity" {
  type        = number
  default     = 0
  description = "The maximum amount of the tasks to run."
}

variable "min_capacity" {
  type        = number
  default     = 0
  description = "The minimum amount of the tasks to run."
}

variable "cpu" {
  type        = number
  default     = 256
  description = "The cpu value to give to the ecs task."
}

variable "memory" {
  type        = number
  default     = 512
  description = "The memory value to give to the ecs task."
}

########################################################################################################################
### Load Balancer/Routing
########################################################################################################################

variable "domain" {
  type        = string
  nullable    = false
  description = "The domain hosting the service. (i.e. 'your-domain.com')"
}

variable "hosted_zone_id" {
  type        = string
  nullable    = false
  description = "The Hosted Zone ID being deployed to."
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = "The VPC ID being deployed to."
}

variable "protocol_version" {
  type        = string
  default     = "GRPC"
  description = "The protocol version of the service. i.e. GRPC or HTTP"
}

variable "lb_security_group_id" {
  type        = string
  nullable    = false
  description = "The Load Balancer's Security Group ID"
}

variable "lb_dns_name" {
  type        = string
  nullable    = false
  description = "The DNS Name of the load balancer hosting the service."
}

variable "lb_zone_id" {
  type        = string
  nullable    = false
  description = "The Zone ID of the load balancer hosting the service."
}

variable "https_listener_arn" {
  type        = string
  description = "The ARN of the https listener."
}

variable "priority" {
  type        = number
  default     = 100
  nullable    = false
  description = "Priority to use for the load balancer traffic."
}

variable "service_domain" {
  type        = string
  default     = ""
  nullable    = false
  description = "The service domain to use as a prefix for traffic routing. If an empty string is given, the prefix defaults to the service name."
}

variable "create_domain" {
  type        = bool
  description = "Whether to create the domain for the service. Set to false if deploying a prelive service which routes via the same domain as the live service."
}