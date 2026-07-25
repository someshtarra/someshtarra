output "vpc_id" {
  description = "The ID of the deployed VPC"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.compute.alb_dns_name
}

output "rds_endpoint" {
  description = "The endpoint of the Amazon RDS instance"
  value       = module.database.rds_endpoint
}
