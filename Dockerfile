# Stage 1: Build the Angular app
FROM node:16 AS build-stage

# Set working directory in the container
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the Angular project files
COPY . .

# Build the Angular application
RUN npm run build --prod

# Stage 2: Serve the app with Nginx
FROM nginx:alpine AS production-stage

# Copy the Angular build output to Nginx
COPY --from=build-stage /app/dist/<your-angular-project> /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
