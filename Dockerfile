# Step 1: Build Stage
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .


ARG MY_SECRET_KEY
ARG API_URL


RUN echo "MY_SECRET_KEY=$MY_SECRET_KEY" > .env && \
    npm run build

# Step 2: Production Stage (Nginx)
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
