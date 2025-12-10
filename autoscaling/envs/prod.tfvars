aws_region = "us-east-1"
name_prefix = "web-prod-asg"
vpc_subnet_ids = ["subnet-05e07cd4009afd717","subnet-06a8f6cfe58dfd721"]
security_group_ids = ["sg-0480a8d9318f183f6"]
ami_id = "ami-068c0051b15cdb816"
instance_type = "t3.small"
key_name = "test-N-virginia"
iam_instance_profile = "arn:aws:iam::197502292053:instance-profile/test-terraform-admin-role"
asg_min = 2
asg_max = 6
asg_desired = 2

tags = {
    Project = "Website"
    Owner = "Platform"
    Environment = "prod"
}