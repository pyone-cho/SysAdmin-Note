FROM ubuntu:20.04

RUN apt-get update && apt-get install nginx -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/list/*

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

