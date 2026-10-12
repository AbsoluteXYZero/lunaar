FROM node:24-alpine

# Install pnpm and git
RUN apk add --no-cache git && npm install -g pnpm

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml ./
# [ZeroLabs] 2026-10-12 1:04 AM - added: copy vendored scramjet tarball before install (see also: package.json)
COPY vendor ./vendor

# Install dependencies (production only)
RUN pnpm install --prod --frozen-lockfile

# Copy source code
COPY . .

# Set production environment
ENV NODE_ENV=production

# Expose port
EXPOSE 8080

# Start the application
CMD ["node", "index.js"]