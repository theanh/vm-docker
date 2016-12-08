server {
  listen 80;
  server_name _ {{ MOBILE_HOST }};

  root /var/www/{{ SITE }}/web;

  location / {
    try_files $uri @rewriteapp;
  }

  location @rewriteapp {
    rewrite ^(.*)$ /{{ INDEX }}.php/$1 last;
  }

  location ~ ^/({{ INDEX_PRO }}|{{ INDEX_DEV }}|{{ CONFIG }})\.php(/|$) {
    fastcgi_pass php-upstream;
    fastcgi_split_path_info ^(.+\.php)(/.*)$;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param HTTPS off;
  }

  error_log /var/log/nginx/{{ MOBILE_HOST }}.error.log;
  access_log /var/log/nginx/{{ MOBILE_HOST }}.access.log;
}
