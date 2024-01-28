FROM node:20.5.0-alpine as builder

LABEL author='Muhammad Yousuf'

LABEL application='Socail Frontend Application'

ARG NODE_ENV=development 
ARG API_URL 
ARG APP_BUILD_VERSION 
ARG APP_BUILD_TIME


ENV REACT_APP_API_URL=$API_URL 

ENV REACT_APP_BUILD_VERSION=$APP_BUILD_VERSION 
ENV REACT_APP_BUILD_TIME=$APP_BUILD_TIME 
ENV NODE_ENV=$NODE_ENV


WORKDIR /app

COPY package*.json ./

RUN yarn install


COPY . .


RUN yarn run build

FROM nginx:stable-perl as runner

WORKDIR /app

COPY --from=builder /app/build /app/html

COPY nginx.conf /app

RUN mkdir -p /app/run 

EXPOSE 80

CMD ["nginx", "-c", "/app/nginx.conf"]