FROM alpine:3.18 AS build
COPY minrootfs /minrootfs
RUN apk update && apk add nginx && rm -rf /var/cache/apk/*
COPY lorem.html /minrootfs/usr/share/nginx/html/index.html

FROM scratch
COPY --from=build /minrootfs /
COPY --from=build /minrootfs/usr/share/nginx/html/index.html /usr/share/nginx/html/index.html
EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]