upstream backend {
    server env-app_blue-1:${HTTP_PORT} max_fails=1 fail_timeout=30s;
    server env-app_green-1:${HTTP_PORT} backup;
}

server {
    listen ${HTTP_PORT};
    return 301 https://$host$request_uri;
}

server {
    listen ${SSL_PORT} ssl;

    ssl_certificate     ${SSL_DIR}/${CERT_FILE};
    ssl_certificate_key ${SSL_DIR}/${KEY_FILE};
    ssl_protocols       TLSv1.2 TLSv1.3;
    ssl_ciphers         HIGH:!aNULL:!MD5;

    location / {
        proxy_pass http://backend;

        proxy_connect_timeout 3s;
        proxy_send_timeout 3s;
        proxy_read_timeout 3s;

        proxy_next_upstream error timeout http_500 http_502 http_503 http_504;
        proxy_next_upstream_tries 2;

        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
