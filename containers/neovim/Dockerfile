FROM alpine:latest

# Active edge repository
RUN sed -i -e 's/v[[:digit:]]\.[[:digit:]]/edge/g' /etc/apk/repositories

# Install Neovim and plugin dependencies
RUN apk add --update musl-dev curl git go python3 python3-dev neovim 
RUN pip3 install --upgrade pip

RUN mkdir /h
RUN chmod 777 /h

# Create user
RUN adduser -D shared
USER shared

ENV PATH $PATH:/home/shared/.local/bin

# Setup runtimes
# ... Go
ENV GOPATH /home/shared/go
RUN mkdir "$GOPATH"

# Configuration
RUN mkdir -p /home/shared/.config/nvim
COPY init.vim /home/shared/.config/nvim

# Setup plugins
# ... Plug
RUN curl -fLo /home/shared/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# ... Go code
RUN go get -u github.com/nsf/gocode

# ... Neovim Python SDK
RUN pip3 install --user neovim

# ... Python auto complete
RUN pip3 install --user nose

# Install plugins
#RUN nvim -s /tmp/install-plugins.vim
RUN nvim +PlugInstall +qa

# Entrypoint
WORKDIR /h

COPY start-nvim.sh /home/shared

ENTRYPOINT [ "/home/shared/start-nvim.sh" ]
