FROM alpine:latest

RUN apk add --update neovim

COPY init.vim $HOME/.config/nvim

ENTRYPOINT nvim
