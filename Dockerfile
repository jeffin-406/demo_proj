# Step 1: Build Stage
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Build argument to choose which env file to use
ARG ENV_FILE=.env.main
RUN cp ${ENV_FILE} .env && npm run build

# Step 2: Production Stage (Nginx)
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
