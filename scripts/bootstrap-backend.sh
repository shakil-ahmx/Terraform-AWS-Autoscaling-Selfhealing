#!/usr/bin/env bash
# Creates the S3 bucket + DynamoDB table used for Terraform remote state & locking.
# Run once per AWS account. Requires AWS CLI configured with admin-level access.
set -euo pipefail

REGION="${AWS_REGION:-ap-south-1}"
ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
BUCKET="${1:-tfstate-${ACCOUNT_ID}-${REGION}}"
TABLE="${2:-tf-aws-asg-lb-cw-locks}"

echo "Region : ${REGION}"
echo "Bucket : ${BUCKET}"
echo "Table  : ${TABLE}"

# NOTE: outside us-east-1 a LocationConstraint is mandatory.
if ! aws s3api head-bucket --bucket "${BUCKET}" 2>/dev/null; then
  aws s3api create-bucket \
    --bucket "${BUCKET}" \
    --region "${REGION}" \
    --create-bucket-configuration "LocationConstraint=${REGION}"
fi

aws s3api put-bucket-versioning --bucket "${BUCKET}" \
  --versioning-configuration Status=Enabled

aws s3api put-bucket-encryption --bucket "${BUCKET}" \
  --server-side-encryption-configuration \
  '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

aws s3api put-public-access-block --bucket "${BUCKET}" \
  --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

if ! aws dynamodb describe-table --table-name "${TABLE}" --region "${REGION}" >/dev/null 2>&1; then
  aws dynamodb create-table \
    --table-name "${TABLE}" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region "${REGION}"
fi

echo
echo "Done. Put this bucket name in environments/<env>/backend.tf: ${BUCKET}"
