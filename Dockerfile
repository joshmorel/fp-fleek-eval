FROM node:12-alpine as builder
WORKDIR '/app'
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

EXPOSE 3000 80

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
