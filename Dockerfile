FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=dotfiles
ARG USER_HOME=/home/$USERNAME
ARG DOTFILES_DIR="$USER_HOME/.dotfiles"

RUN apt-get update && apt-get -y --no-install-recommends install software-properties-common
RUN add-apt-repository ppa:neovim-ppa/unstable && apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    direnv \
    build-essential \
    git \
    zsh \
    curl \
    sudo \
    stow \
    neovim \
    tmux \
    fd-find \
    ripgrep \
    python3 \
    python3-neovim \
    luarocks \
    fzf \
    && rm -rf /var/lib/apt/lists/*

# Download hadolint and make it executable
RUN curl -sSL https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64 \
    -o /usr/local/bin/hadolint \
    && chmod +x /usr/local/bin/hadolint

RUN useradd -m -s /bin/zsh $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR $USER_HOME

COPY --chown=$USERNAME:$USERNAME . "$DOTFILES_DIR"

WORKDIR $DOTFILES_DIR
RUN chmod +x install.sh && ./install.sh

ENV LANG=LANG=C.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

CMD ["/bin/sh", "-c", "/bin/zsh"]
