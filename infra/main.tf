
module "network" {
  source          = "./network"
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "compute" {
  source          = "./compute"
  vpc_id         = module.network.vpc_id
  private_subnets = module.network.private_subnets
  instance_type  = var.instance_type
  key_name       = var.key_name
  docker_compose = var.docker_compose
}

module "loadbalancer" {
  source         = "./loadbalancer"
  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets
  target_group_arn = module.compute.target_group_arn
}

output "load_balancer_dns" {
  value = module.loadbalancer.load_balancer_dns
}
