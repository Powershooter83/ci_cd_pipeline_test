FROM node:latest as node
ENV NODE_OPTIONS=--openssl-legacy-provider
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2
FROM nginx:latest

COPY --from=node /usr/src/app/dist/testapp /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
