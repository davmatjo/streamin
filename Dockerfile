FROM golang:alpine AS builder

WORKDIR /
RUN mkdir /streamin-be
RUN mkdir /streamin-fe

RUN apk update
RUN apk add npm

WORKDIR /streamin-be
COPY backend .
COPY backend .

RUN go mod download

WORKDIR /streamin-fe
COPY frontend .
COPY frontend .

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

COPY --from=builder /backend .
COPY --from=builder /frontend .

ENTRYPOINT ["/app/streamin"]