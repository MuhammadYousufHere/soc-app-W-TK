FROM node:20.5.0-alpine as builder

LABEL author='Muhammad Yousuf'

LABEL application='Socail BE Server'

ARG NODE_ENV=development 
ARG CLIENT_URL=http://localhost:3000
ARG MONGODB_URI=mongodb://127.0.0.1:27017/db_social
ARG PORT=4000

# JWT
ARG SECRET=
ARG REFRESH_SECRET=

# Crypto
ARG CRYPTO_KEY=

# Nodemailer
ARG EMAIL=email
ARG PASSWORD=password
ARG EMAIL_SERVICE=Zoho/Gmail/others

# Content Moderation
ARG PERSPECTIVE_API_KEY=
ARG TEXTRAZOR_API_KEY=
ARG INTERFACE_API_KEY=
ARG PERSPECTIVE_API_DISCOVERY_URL=https://commentanalyzer.googleapis.com/$discovery/rest?version=v1alpha1
ARG TEXTRAZOR_API_URL=https://api.textrazor.com/
ARG INTERFACE_API_URL=https://api-inference.huggingface.co/models/facebook/bart-large-mnli

# For flask using bart-large-mnli
ARG CLASSIFIER_API_URL=http://127.0.0.1:5000/classify


# ENVS

ENV NODE_ENV=${NODE_ENV} 
ENV CLIENT_URL=${CLIENT_URL}
ENV MONGODB_URI=${MONGODB_URI}
ENV PORT=${PORT}

# JWT
ENV SECRET=${SECRET}
ENV REFRESH_SECRET=${REFRESH_SECRET}

# Crypto
ENV CRYPTO_KEY=${CRYPTO_KEY}

# Nodemailer
ENV EMAIL=${EMAIL_SERVICE}
ENV PASSWORD=${PASSWORD}
ENV EMAIL_SERVICE=${EMAIL_SERVICE}

# Content Moderation
ENV PERSPECTIVE_API_KEY=${PERSPECTIVE_API_KEY}
ENV TEXTRAZOR_API_KEY=
ENV INTERFACE_API_KEY=
ENV PERSPECTIVE_API_DISCOVERY_URL=${PERSPECTIVE_API_DISCOVERY_URL}
ENV TEXTRAZOR_API_URL=${TEXTRAZOR_API_URL}
ENV INTERFACE_API_URL=${INTERFACE_API_URL}

# For flask using bart-large-mnli
ENV CLASSIFIER_API_URL=${CLASSIFIER_API_URL}





WORKDIR /app

COPY package.json ./

RUN yarn install


COPY . .


EXPOSE 4000

CMD ["npm", "start"]