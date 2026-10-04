# osgiliath

Custom [uCore](https://github.com/ublue-os/ucore) image for a single always-on VPS. uCore is
Fedora CoreOS with batteries included; this image layers the few packages the host needs before it
boots, so nothing is installed by hand on the running system and a rebuild reproduces it exactly.

Layered on top of `ghcr.io/ublue-os/ucore:stable`:

| Package | Why |
|---|---|
| `tailscale` | Private network access; the host exposes nothing publicly except what the edge proxy forwards |
| `1password-cli` | Services pull secrets from 1Password service accounts at start, not from files on disk |
| `vdirsyncer` | CalDAV/CardDAV sync |
| `git` | Pulling deploy repos onto the host |

## Build

GitHub Actions ([`build.yml`](.github/workflows/build.yml)) builds and pushes the image to
`ghcr.io/nkbooth/osgiliath`.

## Use

```bash
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/nkbooth/osgiliath:latest
sudo systemctl reboot
```

Updates are staged by `rpm-ostree upgrade` and take effect on the next reboot.
