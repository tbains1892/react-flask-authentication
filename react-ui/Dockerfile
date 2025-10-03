# ==================== BUILD STAGE ====================
# Use specific Node version for reproducibility
FROM node:16-alpine AS build

# Set working directory
WORKDIR /app

# Copy package files first for better layer caching
# If dependencies don't change, Docker reuses this layer
COPY package.json package-lock.json* ./

# Install dependencies
# npm ci is faster and more reliable for production builds
RUN npm ci --silent

# Copy source code
COPY . .

# Set the backend API URL for production build
# This gets baked into the React build at build time
ARG REACT_APP_BACKEND_SERVER=http://localhost:5001/api/
ENV REACT_APP_BACKEND_SERVER=$REACT_APP_BACKEND_SERVER

# Build the React app for production
# Creates optimized static files in /app/build
RUN npm run build

# ==================== PRODUCTION STAGE ====================
# Use nginx to serve static files (much smaller and faster than Node)
FROM nginx:alpine

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built React app from build stage to nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 (nginx default)
EXPOSE 80

# Start nginx
# daemon off keeps nginx in foreground (required for Docker)
CMD ["nginx", "-g", "daemon off;"]