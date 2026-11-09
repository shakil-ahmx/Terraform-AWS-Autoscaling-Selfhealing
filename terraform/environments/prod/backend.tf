# Remote state (recommended). Steps:
#   1. Run ../../../scripts/bootstrap-backend.sh once to create the S3 bucket + DynamoDB lock table.
#   2. Uncomment the block below and set the bucket name printed by the script.
#   3. Run: terraform init -migrate-state
#
# terraform {
#   backend "s3" {
#     bucket         = "REPLACE-ME-tfstate-ap-south-1"
#     key            = "tf-aws-asg-lb-cw/prod/terraform.tfstate"
#     region         = "ap-south-1"
#     dynamodb_table = "tf-aws-asg-lb-cw-locks"
#     encrypt        = true
#   }
# }
