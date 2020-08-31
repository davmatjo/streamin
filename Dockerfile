FROM golang:alpine AS builder

WORKDIR /
RUN mkdir /backend
RUN mkdir /frontend

RUN apk update
RUN apk add npm

#####
# Acquire and build frontend dependencies
#####
WORKDIR /frontend
COPY frontend/package-lock.json .
COPY frontend/package.json .

RUN npm install

#####
# Acquire and build backend dependencies
#####
WORKDIR /backend
COPY backend/go.mod .
COPY backend/go.sum .

RUN go mod download

#############################

WORKDIR /frontend
COPY frontend .
RUN npm run build

WORKDIR /backend
COPY backend .
RUN go build -o streamin .

#############################

FROM alpine

RUN mkdir /app
RUN mkdir /app/web
WORKDIR /app

COPY --from=builder /backend/streamin .
COPY --from=builder /frontend/build web

ENTRYPOINT ["/app/streamin"]