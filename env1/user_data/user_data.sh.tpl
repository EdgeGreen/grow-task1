#!/bin/bash

apt-get update -y
apt-get install awscli -y
INSTANCE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
echo "<h1>$INSTANCE_IP</h1>" > index.html
nohup busybox httpd -f -p 80 &
echo "*/1 * * * * aws s3 cp /index.html s3://${s3_bucket_address}/index.html" > /tmp/mycrontab.txt
bash -c 'crontab /tmp/mycrontab.txt'
