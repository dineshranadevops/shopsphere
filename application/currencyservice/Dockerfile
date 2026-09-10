FROM node:20-bookworm-slim AS builder

WORKDIR /usr/src/app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       python3 \
       make \
       g++ \
       ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

FROM node:20-bookworm-slim

WORKDIR /usr/src/app

ENV NODE_ENV=production

COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY . .

USER node

EXPOSE 7000

ENTRYPOINT ["node", "server.js"]
