module "vpc" {
  source = "./vpc"
}

module "auto-scaling" {
  source          = "./auto-scaling"
  HTTP_SG_ID      = module.vpc.HTTP_SG_ID
  SSH_SG_ID       = module.vpc.SSH_SG_ID
  key_name        = module.vpc.key_name
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.subnets_ids
  public_subnet01 = module.vpc.public_subnet01
  public_subnet02 = module.vpc.public_subnet02
}

