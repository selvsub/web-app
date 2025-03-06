# Stage 1: Build stage (Alpine-based image)
FROM alpine:3.18 AS build

# Install Nginx and its dependencies
RUN apk update && apk add --no-cache nginx

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Stage 2: Final stage (scratch-based image)
FROM scratch

# Copy the Nginx binary and its dependencies from the build stage
COPY --from=build /usr/sbin/nginx /usr/sbin/nginx
COPY --from=build /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=build /etc/nginx /etc/nginx
COPY --from=build /var/lib/nginx /var/lib/nginx
COPY --from=build /var/log/nginx /var/log/nginx

# Expose port 80
EXPOSE 80

# Set the entrypoint to Nginx
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]