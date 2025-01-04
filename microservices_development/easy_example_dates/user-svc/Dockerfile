FROM alpine
WORKDIR /app
ADD ./user-svc/static static
ADD ./user-svc/build build
ENTRYPOINT build/user-svc 