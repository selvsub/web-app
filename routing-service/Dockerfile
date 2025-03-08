# Use the official Nginx base image
FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf

COPY custom_404.html /var/www/html/custom_404.html

COPY 404.jpg /var/www/html/images/404.jpg

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]