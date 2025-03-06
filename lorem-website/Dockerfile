# Stage 1: Build the minimal root filesystem
FROM alpine:3.18 AS build
RUN mkdir -p /minrootfs && \
    wget https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/aarch64/alpine-minirootfs-3.21.3-aarch64.tar.gz -O /tmp/alpine-minirootfs.tar.gz && \
    tar -xzf /tmp/alpine-minirootfs.tar.gz -C /minrootfs && \
    rm /tmp/alpine-minirootfs.tar.gz

# Install nginx and copy necessary files into /minrootfs
RUN apk update && apk add --no-cache nginx
RUN cp -a /etc/nginx /minrootfs/etc/nginx
RUN cp -a /usr/sbin/nginx /minrootfs/usr/sbin/nginx
RUN cp -a /var/lib/nginx /minrootfs/var/lib/nginx
RUN cp -a /var/log/nginx /minrootfs/var/log/nginx
RUN mkdir -p /minrootfs/usr/share/nginx/html
COPY lorem.html /minrootfs/usr/share/nginx/html/index.html

# Stage 2: Create the final image from scratch
FROM scratch
COPY --from=build /minrootfs /
EXPOSE 80
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]