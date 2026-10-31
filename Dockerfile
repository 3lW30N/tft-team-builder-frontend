FROM node:22-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM httpd:2.4-alpine

COPY --from=build /app/dist/frontend/browser/ /usr/local/apache2/htdocs/
RUN sed -i \
    -e 's/^#\(LoadModule proxy_module\)/\1/' \
    -e 's/^#\(LoadModule proxy_http_module\)/\1/' \
    -e 's/^#\(LoadModule rewrite_module\)/\1/' \
    /usr/local/apache2/conf/httpd.conf \
 && echo "Include conf/extra/app.conf" >> /usr/local/apache2/conf/httpd.conf
COPY app.conf /usr/local/apache2/conf/extra/app.conf

EXPOSE 80
