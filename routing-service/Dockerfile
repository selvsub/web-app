# Use the official Nginx base image
FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 82

CMD ["nginx", "-g", "daemon off;"]