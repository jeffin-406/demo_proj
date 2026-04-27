# Step 1: Build stage
FROM node:18-alpine AS build
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy EVERYTHING from your folder (this includes the .env.dev created by GitHub)
COPY . . 

# Define the argument
ARG ENV_FILE

# Debugging and Building
RUN echo "Checking for file: $ENV_FILE" && \
    ls -la $ENV_FILE && \
    cp $ENV_FILE .env && \
    CI=false npm run build

# Step 2: Production stage (Nginx)
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
