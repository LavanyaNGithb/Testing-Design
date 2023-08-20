# Use the official Nginx image as the base image
FROM nginx:latest

# Set a label for the maintainer
LABEL maintainer="Your Name <your.email@example.com>"

# Remove the default Nginx welcome page
RUN rm -rf /usr/share/nginx/html/*

# Create a non-root user and group with the same IDs as the host user
ARG UID=1000
ARG GID=1000
RUN addgroup --gid $GID myuser && adduser --uid $UID --gid $GID --disabled-password --gecos '' myuser

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy your static content into the Nginx document root
COPY --chown=myuser:myuser ./static-content .

# Expose port 80 to allow incoming HTTP traffic
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
