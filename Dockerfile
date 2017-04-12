FROM alpine:latest

ADD nginx-push-stream-module /src/nginx-push-stream-module
ADD nginx-1.12.0 /src/nginx

RUN apk add --no-cache g++ && \
  apk add --no-cache pcre-dev && \
  apk add --no-cache zlib-dev && \
  apk add --no-cache make && \
  cd /src/nginx && \
  ./configure --add-module=../nginx-push-stream-module && \
  make && \
  cd /src/nginx && \
  make install && \
  make clean && \
  rm -rf /src/nginx/ /var/cache/apk/ /src/nginx-push-stream-module && \
  apk del g++ make
  
CMD /usr/local/nginx/sbin/nginx -g 'daemon off;'

EXPOSE 9080 9443
