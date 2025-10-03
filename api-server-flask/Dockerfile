# Use specific Python version for reproducibility
# Alpine variant is smaller (reduces image size by ~600MB)
FROM python:3.9-alpine

# Set working directory
WORKDIR /app

# Install system dependencies required for Python packages
# These are needed for packages like psycopg2, cryptography, etc.
RUN apk add --no-cache gcc musl-dev linux-headers

# Copy only requirements first for better layer caching
# If requirements don't change, Docker reuses this layer
COPY requirements.txt .

# Upgrade pip to latest version for security and features
RUN pip install --upgrade pip

# Install Python dependencies
# --no-cache-dir reduces image size by not storing pip cache
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
# Done after pip install so code changes don't invalidate dependency layer
COPY . .

# Expose port that gunicorn will run on
EXPOSE 5005

# Use gunicorn for production-ready WSGI server
# Better than Flask's built-in server for handling multiple requests
CMD ["gunicorn", "--config", "gunicorn-cfg.py", "run:app"]