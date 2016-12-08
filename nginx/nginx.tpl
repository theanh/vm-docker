user www-data;
worker_processes 2;

error_log /var/log/nginx/error.log warn;
pid /run/nginx.pid;

events {
  worker_connections 1024;
  multi_accept on;
  use epoll;
}

http {
  server_tokens       off;
  sendfile            on;
  tcp_nopush          on;
  tcp_nodelay         on;
  keepalive_timeout   15;
  types_hash_max_size 1024;

  include             /etc/nginx/mime.types;
  default_type        application/octet-stream;

  log_format  main    '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
  access_log          /var/log/nginx/access.log  main;

  gzip                on;
  gzip_http_version   1.0;
  gzip_comp_level     2;
  gzip_proxied        any;
  gzip_vary           off;
  gzip_types          text/plain text/css application/x-javascript text/xml application/xml application/rss+xml application/atom+xml text/javascript application/javascript application/json text/mathml;
  gzip_min_length     1000;
  gzip_disable        "MSIE [1-6]\.";

  variables_hash_max_size       1024;
  variables_hash_bucket_size    64;
  server_names_hash_bucket_size 64;
  types_hash_bucket_size        64;
  client_body_buffer_size       8k;
  client_max_body_size          5m;

  include /etc/nginx/conf.d/*.conf;
  include /etc/nginx/sites-enabled/*;

  open_file_cache max=100;
}

daemon off;
