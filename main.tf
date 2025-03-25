module "vpc" {
  source = "./vpc"
}

module "auto-scaling" {
  source          = "./auto-scaling"
  HTTP_SG_ID      = module.vpc.HTTP_SG_ID
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.subnets_ids
}

