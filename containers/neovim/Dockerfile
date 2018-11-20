FROM alpine:latest

# Create user
RUN adduser -D shared

# Active edge repository
RUN sed -i -e 's/v[[:digit:]]\.[[:digit:]]/edge/g' /etc/apk/repositories

# Install Neovim and plugin dependencies
RUN apk add --update musl-dev git go python3 python3-dev neovim 

# Setup plugin dependencies
# ... Go
RUN mkdir /go
ENV GOPATH /go

# ... Python
RUN pip3 install --upgrade pip

# Setup plugins
# ... Go code
RUN go get -u github.com/nsf/gocode

# ... Neovim Python SDK
RUN pip3 install neovim

# Configuration
RUN mkdir -p $HOME/.config/nvim
COPY init.vim $HOME/.config/nvim

# Entrypoint
RUN mkdir /shared
WORKDIR /shared

ENTRYPOINT [ "/usr/bin/nvim" ]
