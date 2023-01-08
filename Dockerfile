FROM node:16.19.0-buster-slim AS build
WORKDIR /app

# RESTORE
COPY package.json /app
COPY yarn.lock /app
RUN yarn install

# BUILD
# COPY SOURCES
COPY . /app
RUN yarn build

FROM nginx
WORKDIR /usr/share/nginx/html

# CONFIGURATION
COPY default.conf /etc/nginx/conf.d/

# SOURCES
COPY --from=build /app/dist/pocket-application-web/ .
