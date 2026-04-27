# Build stage
FROM node:18-alpine AS build
WORKDIR /app

# 1. Install dependencies first (better caching)
COPY package*.json ./
RUN npm install

# 2. Copy the rest of the code
COPY . .

# 3. Environment Setup & Build
ARG ENV_FILE
# The 'ls' helps us see if the file actually exists in the runner
RUN ls -la && \
    cp ${ENV_FILE} .env && \
    CI=false npm run build

# Production stage
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
