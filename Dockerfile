FROM python:3

ENV DEBIAN_FRONTEND=noninteractive

ARG DOCKER_UID=1000
ARG DOCKER_USER=docker
ARG DOCKER_GID=1000
ARG DOCKER_GROUP=docker

RUN apt-get -y update \
    && apt-get install -y locales \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN apt-get install -y \
    autoconf \
    automake \
    cmake \
    clangd \
    curl \
    doxygen \
    g++ \
    gdb \
    gem \
    gettext \
    git \
    libboost-dev \
    libbz2-dev \
    libtool \
    libtool-bin \
    nkf \
    ninja-build \
    ruby \
    ruby-dev \
    silversearcher-ag \
    socat \
    sudo \
    peco \
    pkg-config \
    unzip \
    wget \
    zsh
RUN pip3 install --upgrade pip \
    && pip3 install -U \
    msgpack \
    neovim \
    python-language-server \
    pynvim
RUN curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && npm install -g neovim
RUN mkdir -p /tmp \
    && git clone --depth 1 https://github.com/neovim/neovim /tmp/neovim \
    && cd /tmp/neovim \
    && make CMAKE_BUILD=RelWithDebInfo \
    && make install \
    && rm -rf /tmp/neovim

COPY ./clip.sh /usr/local/bin
RUN ln -s /usr/local/bin/clip.sh /usr/local/bin/xsel
RUN ln -s /usr/local/bin/clip.sh /usr/local/bin/xclip

RUN groupadd -g ${DOCKER_GID} ${DOCKER_GROUP} \
    && useradd -m -u ${DOCKER_UID} -g ${DOCKER_GID} --create-home --shell /bin/zsh ${DOCKER_USER} \
    && echo "${DOCKER_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && chown -R ${DOCKER_USER}:${DOCKER_GROUP} /home/${DOCKER_USER}
USER ${DOCKER_USER}
WORKDIR /home/${DOCKER_USER}
ENV HOME /home/${DOCKER_USER}

RUN mkdir -p ${HOME}/.local/bin
COPY ./git-credential-github-token /home/docker/.local/bin
RUN git config --global url."https://github.com/KowerKoint/".insteadOf ssh://git@github.com/KowerKoint/ \
    && git config --global credential.helper github-token
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH ${PATH}:${HOME}/.cargo/bin
RUN cargo install lsd

RUN git clone --depth 1 https://github.com/zplug/zplug ${HOME}/.zplug
RUN git clone https://github.com/KowerKoint/dotfiles.git \
    && dotfiles/.bin/install.sh

CMD ["zsh"]
