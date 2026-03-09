module "internal_service" {
  source = "project-init/internal-service/aws"
  # Project Init recommends pinning every module to a specific version
  # version = "vX.X.X"

  # Common
  environment  = "staging"
  service_name = "api"

  # ECS Cluster/Service
  ecs_cluster_name = "cluster"
  ecs_cluster_arn  = "cluster:arn"
  subnets = [
    "subnet-1"
  ]
  security_groups = [
    "sg-1"
  ]

  # ECS Task
  image = "111111111111.dkr.ecr.us-east-1.amazonaws.com/api:v0.1.0"
  environment_variables = [
    {
      name  = "REGION"
      value = "us-east-1"
    },
  ]

  cpu    = 256
  memory = 256

  desired_count = 1
  min_capacity  = 1
  max_capacity  = 1

  sidecars = [
    {
      name      = "shuttle"
      image     = "111111111111.dkr.ecr.us-east-1.amazonaws.com/shuttle:v0.1.0"
      essential = false
      cpu       = 128
      memory    = 256
      port_mappings = [
        { containerPort = 4317, hostPort = 4317, protocol = "tcp" }
      ]
      environment_variables = [
        {
          name  = "VERSION"
          value = "us-east-1"
        },
      ]
      secrets = [
        {
          name      = "TEST_SECRET",
          valueFrom = "${module.grafana_secret.secret_arn}:TEST_SECRET::"
        },
      ]
    },
  ]
  sidecars_cpu    = 128
  sidecars_memory = 256

  # Load Balancer/Routing
  vpc_id               = "vpc-id"
  domain               = "my-domain.com"
  hosted_zone_id       = "zone-id"
  lb_security_group_id = "lb-sg-id"
  lb_dns_name          = "lb-dns-name"
  lb_zone_id           = "lb-zone-id"
  https_listener_arn   = "listener-arn"
}