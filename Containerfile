FROM ghcr.io/ublue-os/ucore:stable

# Add 1Password RPM repo and import its signing key
COPY 1password.repo /etc/yum.repos.d/1password.repo
RUN rpm --import https://downloads.1password.com/linux/keys/1password.asc

# Layer packages into the image (tailscale and vdirsyncer are in Fedora repos)
RUN rpm-ostree install -y \
    tailscale \
    1password-cli \
    vdirsyncer \
    git && \
    ostree container commit
