FROM alpine:latest AS builder
ARG MINROOTFS_URL=https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/aarch64/alpine-minirootfs-3.21.3-aarch64.tar.gz
WORKDIR /rootfs

RUN apk add --no-cache curl tar && \
    curl -L ${MINROOTFS_URL} -o alpine-minirootfs.tar.gz && \
    tar -xzf alpine-minirootfs.tar.gz && \
    rm alpine-minirootfs.tar.gz

COPY lorem.html /rootfs/index.html
COPY nginx.conf /rootfs/nginx.conf


FROM scratch
COPY --from=builder /rootfs/ /
RUN apk update --no-check-certificate

RUN apk add --no-check-certificate nginx 
COPY --from=builder /rootfs/index.html /var/www/html/index.html
COPY --from=builder /rootfs/nginx.conf /etc/nginx/nginx.conf

USER nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]