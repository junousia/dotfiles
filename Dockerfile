FROM allaman/nvim-base:stable

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=dotfiles
ARG USER_HOME=/home/$USERNAME
ARG DOTFILES_DIR="$USER_HOME/.dotfiles"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    direnv \
    build-essential \
    git \
    zsh \
    curl \
    sudo \
    stow \
    neovim \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/zsh $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR $USER_HOME

COPY --chown=$USERNAME:$USERNAME . "$DOTFILES_DIR"

WORKDIR $DOTFILES_DIR
RUN chmod +x install.sh && ./install.sh

CMD ["/bin/zsh"]
