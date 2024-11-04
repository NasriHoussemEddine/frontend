# Stage 1: Build the Angular app
FROM node:16 AS build-stage

# Set working directory in the container
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy the Angular project files
COPY . .

# Build the Angular application
RUN npm run build --prod

# List the contents of the /app/dist directory
RUN ls -la /app/dist

# Stage 2: Serve the app with Nginx
FROM nginx:alpine AS production-stage

# Copy the Angular build output to Nginx
COPY --from=build-stage /app/dist/crudtuto-Front /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
