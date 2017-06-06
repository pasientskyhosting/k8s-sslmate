#!/bin/sh
export GOPATH=$(PWD)/packages/
rm /bin/k8s-sslmate
go get
GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o ./bin/k8s-sslmate .

if [ $? -eq 0 ]; then
    git commit -am "Binary build"
    git push
fi
