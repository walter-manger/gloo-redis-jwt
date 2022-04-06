FROM --platform=linux/amd64 nginx
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /www
COPY ./index.html /www
COPY ./callback /www/callback
COPY ./logout /www/logout
