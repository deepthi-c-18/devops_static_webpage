# Use an lightweight, official Nginx image as the base
FROM nginx:alpine

# Copy the simple index.html file into the Nginx HTML directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80

# The default command of the Nginx image automatically starts the server.
