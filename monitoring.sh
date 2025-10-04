#!/bin/bash

# Docker Container Monitoring Script
# This script displays real-time health and resource usage of containers

echo "========================================"
echo "   Docker Container Monitoring"
echo "========================================"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop."
    exit 1
fi

echo "📊 Container Status:"
echo "-------------------"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "💚 Health Checks:"
echo "-------------------"
# Show health status for each container
for container in $(docker ps --format "{{.Names}}"); do
    health=$(docker inspect --format='{{.State.Health.Status}}' $container 2>/dev/null)
    if [ -n "$health" ]; then
        if [ "$health" = "healthy" ]; then
            echo "✅ $container: $health"
        else
            echo "⚠️  $container: $health"
        fi
    else
        echo "ℹ️  $container: no health check configured"
    fi
done

echo ""
echo "📈 Resource Usage:"
echo "-------------------"
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"

echo ""
echo "-------------------"
echo "Monitoring complete! Run this script anytime to check container health."
echo "For continuous monitoring, run: watch -n 5 ./monitoring.sh"