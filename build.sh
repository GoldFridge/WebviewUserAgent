#!/usr/bin/env bash
set -e

OS=$(uname -s)

echo "Detected OS: $OS"

if [[ "$OS" == "Linux" ]]; then
    echo "Installing dependencies for Linux..."
    sudo apt-get update
    sudo apt-get install -y \
        libgtk-3-dev \
        libwebkit2gtk-4.1-dev \
        build-essential \
        pkg-config
    echo "Dependencies installed."
else
    echo "macOS detected — no dependencies required."
fi

if ! command -v go &> /dev/null
then
    echo "Go is not installed. Please install Go 1.25+ and try again."
    exit 1
fi

echo "Tidying Go modules..."
go mod tidy

echo "Building executable..."
go build -o webview_useragent ./cmd/app/main.go 2>/dev/null || go build -o webview_useragent .

echo "Build complete: ./webview_useragent"

echo "Running application..."
./webview_useragent