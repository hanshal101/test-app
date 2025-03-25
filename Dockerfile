FROM node:23-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

FROM node:23-alpine

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app .

RUN npm install --production

ENV NODE_ENV=production

EXPOSE 3000

CMD ["node", "app.js"]
