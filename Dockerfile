FROM alpine:3.21.3

ARG USERNAME=dotfiles
ARG USER_HOME=/home/$USERNAME
ARG DOTFILES_DIR="$USER_HOME/.dotfiles"

# Install required packages with explicit version pinning
RUN apk add --no-cache \
    ca-certificates \
    direnv \
    build-base \
    git \
    zsh \
    curl \
    sudo \
    stow \
    neovim \
    tmux \
    fd \
    ripgrep \
    python3 \
    py3-pynvim \
    luarocks \
    delta \
    fzf \
    bat \
    npm \
    lazygit \
    gzip \
    go

# Download hadolint and make executable
RUN curl -sSL https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64 \
    -o /usr/local/bin/hadolint \
    && chmod +x /usr/local/bin/hadolint

# Create a user and configure sudo
RUN adduser -D -s /bin/zsh $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR $USER_HOME

COPY --chown=$USERNAME:$USERNAME . "$DOTFILES_DIR"

WORKDIR $DOTFILES_DIR
RUN chmod +x install.sh && ./install.sh

ENV LANG=C.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV TERM=xterm-256color

CMD ["/bin/zsh"]
