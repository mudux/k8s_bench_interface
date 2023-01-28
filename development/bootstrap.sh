#!/bin/bash

# Initialize Bench
bench init --skip-redis-config-generation --verbose --apps_path=apps.json frappe-bench

# Change to frappe-bench
cd frappe-bench

# Set global bench configs
echo "Configuring Bench ..."
echo "Set db_host to mariadb"
bench set-config -g db_host mariadb
echo "Set redis_cache to redis://redis-cache:6379"
bench set-config -g redis_cache redis://redis-cache:6379
echo "Set redis_queue to redis://redis-queue:6379"
bench set-config -g redis_queue redis://redis-queue:6379
echo "Set redis_socketio to redis://redis-socketio:6379"
bench set-config -g redis_socketio redis://redis-socketio:6379
echo "Setup requirements"
bench setup requirements

# Create custom.localhost site
echo "Create http://k8s-bench-ui.localhost:8000 site"
bench new-site \
  --no-mariadb-socket \
  --db-root-password=123 \
  --admin-password=admin \
  k8s-bench-ui.localhost
# C