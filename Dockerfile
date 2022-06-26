FROM golang:1.18-alpine as build
WORKDIR /apps
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN go build -o goginrest .

FROM alpine:latest
RUN mkdir /apps
WORKDIR /apps
COPY --from=build /apps/goginrest .
CMD ["/apps/goginrest"]
