FROM golang:alpine AS builder

WORKDIR /
RUN mkdir /streamin-be
RUN mkdir /streamin-fe

RUN apk update
RUN apk add npm

WORKDIR /streamin-be
COPY streamin-be/go.mod .
COPY streamin-be/go.sum .

RUN go mod download

WORKDIR /streamin-fe
COPY streamin-fe/package.json .
COPY streamin-fe/package-lock.json .

RUN npm install

WORKDIR /
COPY . .

WORKDIR /streamin-be
RUN go build -o streamin .

WORKDIR /streamin-fe
RUN npm run build

FROM alpine

RUN mkdir /app
WORKDIR /app

COPY --from=builder /streamin-be/streamin .
COPY --from=builder /streamin-fe/build .

ENTRYPOINT ["/app/streamin"]