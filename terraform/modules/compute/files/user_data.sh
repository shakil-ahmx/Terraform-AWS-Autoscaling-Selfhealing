#!/bin/bash
# Amazon Linux 2023: install Apache and serve a static page that shows the instance ID/AZ.
set -euxo pipefail

dnf install -y httpd stress-ng

TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 300")
IID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)

cat > /var/www/html/index.html <<HTML
<!DOCTYPE html>
<html>
<head><title>ASG + ALB Demo</title></head>
<body style="font-family:sans-serif;text-align:center;margin-top:80px">
  <h1>Hello from AWS ap-south-1 (Mumbai)</h1>
  <p>Served by instance <b>$IID</b> in <b>$AZ</b></p>
</body>
</html>
HTML

systemctl enable --now httpd
