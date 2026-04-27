# Build stage
FROM node:18-alpine AS build
WORKDIR /app

# Copy package files and install
COPY package*.json ./
RUN npm install

# Copy everything else (including the .env files created by GitHub)
COPY . .

# We must re-declare the ARG inside the build stage to use it in RUN
ARG ENV_FILE
RUN echo "Building with file: $ENV_FILE" && \
    ls -la $ENV_FILE && \
    cp $ENV_FILE .env && \
    CI=false npm run build

# Production stage
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
