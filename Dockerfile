FROM node:20-slim

# Install runtime dependencies for audio support (node-wav-player/sox-play)
RUN apt-get update && apt-get install -y --no-install-recommends \
    sox \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package files and install production dependencies
COPY package*.json ./
RUN npm ci --omit=dev

# Copy application source
COPY . .

# Expose HTTP and OSC ports
EXPOSE 5656
EXPOSE 57121/udp

CMD ["node", "server.js"]
