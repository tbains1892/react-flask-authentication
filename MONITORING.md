# Monitoring Setup

This project includes basic container monitoring to track the health and performance of all services.

## Features

- **Container Status**: Shows which containers are running and their uptime
- **Health Checks**: Displays health status for each service (configured in docker-compose.yml)
- **Resource Usage**: Monitors CPU, memory, and network I/O for each container

## Usage

### One-time Check

Run the monitoring script to get a snapshot of all containers:

```bash
./monitoring.sh
```

### Continuous Monitoring

To watch container metrics update every 5 seconds:

```bash
watch -n 5 ./monitoring.sh
```

Press `Ctrl+C` to stop.

### Using Docker's Built-in Commands

You can also use Docker's native commands:

**View running containers:**
```bash
docker ps
```

**View resource usage (live updates):**
```bash
docker stats
```

**Check container logs:**
```bash
docker logs <container_name>
# Example:
docker logs flask_api
docker logs react_ui
```

**Inspect container health:**
```bash
docker inspect --format='{{.State.Health.Status}}' <container_name>
```

## Health Checks

Health checks are configured in `docker-compose.yml` for all services:

- **flask_api**: Checks HTTP endpoint every 30 seconds
- **nginx**: Verifies proxy is responding every 30 seconds  
- **react_ui**: Confirms web server is serving content every 30 seconds

If a container fails its health check 3 times, it's marked as unhealthy.

## Monitoring in Production

For production environments, consider implementing:
- **Prometheus + Grafana**: Full-featured metrics and visualization
- **ELK Stack**: Centralized logging (Elasticsearch, Logstash, Kibana)
- **Cloud-native monitoring**: AWS CloudWatch, Azure Monitor, or Google Cloud Monitoring