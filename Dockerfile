# Stage 1: Build the Angular app
FROM node:16 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of the application code
COPY . .

# Build the Angular application
RUN npm run build

# Stage 2: Serve the application using Nginx
FROM nginx:alpine
# Copy the built application from the previous stage
COPY --from=build /app/dist/crudtuto-Front /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/
# Expose port 3000
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
