FROM alpine:latest AS builder
ARG MINROOTFS_URL=https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/aarch64/alpine-minirootfs-3.21.3-aarch64.tar.gz
WORKDIR /rootfs

RUN apk add --no-cache curl tar && \
    curl -L ${MINROOTFS_URL} -o alpine-minirootfs.tar.gz && \
    tar -xzf alpine-minirootfs.tar.gz && \
    rm alpine-minirootfs.tar.gz

COPY lorem.html /rootfs/var/www/html/index.html
COPY nginx.conf /rootfs/etc/nginx/nginx.conf


FROM scratch
COPY --from=builder /rootfs/ /

# Install Nginx and create a non-root user
RUN apk add --no-cache nginx && \
    adduser -D -u 1000 nginxuser && \
    mkdir -p /var/log/nginx /var/cache/nginx /var/lib/nginx/tmp /run/nginx && \
    chown -R nginxuser:nginxuser /var/log/nginx /var/cache/nginx /var/lib/nginx /run/nginx /var/www/html && \
    chmod -R 755 /var/log/nginx /var/cache/nginx /var/lib/nginx /run/nginx /var/www/html

COPY --from=builder --chown=nginxuser:nginxuser /rootfs/var/www/html/index.html /var/www/html/index.html
COPY --from=builder --chown=nginxuser:nginxuser /rootfs/etc/nginx/nginx.conf /etc/nginx/nginx.conf

USER nginxuser

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]