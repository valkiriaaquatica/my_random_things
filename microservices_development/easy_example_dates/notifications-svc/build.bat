set CGO_ENABLED=0
set GOOS=linux
set GOARCH=amd64
go build -o build/notifications-svc cmd/main.go