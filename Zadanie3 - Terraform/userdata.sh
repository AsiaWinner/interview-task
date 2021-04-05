#! /bin/bash
amazon-linux-extras install nginx1 -y
systemctl start nginx.service
systemctl enable nginx.service