# Stage 1: Build the minimal root filesystem
FROM alpine:3.18 AS build
RUN mkdir -p /minrootfs && \
    wget https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/aarch64/alpine-minirootfs-3.21.3-aarch64.tar.gz -O /tmp/alpine-minirootfs.tar.gz && \
    tar -xzf /tmp/alpine-minirootfs.tar.gz -C /minrootfs && \
    rm /tmp/alpine-minirootfs.tar.gz
RUN apk update && apk add nginx && rm -rf /var/cache/apk/*
COPY index.html /minrootfs/usr/share/nginx/html/index.html

# Stage 2: Create the final image from scratch
FROM scratch
COPY --from=build /minrootfs /
COPY --from=build /minrootfs/usr/share/nginx/html/index.html /usr/share/nginx/html/index.html
EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]