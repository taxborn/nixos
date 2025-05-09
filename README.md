# taxborn's [NixOS](https://nixos.org) configuration
I've touched on NixOS here and there over the past 2 years or so. For the most part it has been great,
aside from the oddities surrounding it's non-[FHS](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)
compliance and a few other things mostly hindered by my lack of understanding. This is my attempt at making
a somewhat sensible configuration that I can deploy to my laptop(s), desktop, and homelab.

# Goals, features, wishlist?
- [X] Flakes
- [X] Impermanent [1] [2] [3] [5]
- [X] btrfs [4] [5]
- [X] encrypted (aside from headless systems)
  - [ ] eventually a yubikey or similar solution for encrypting headless systems
- [X] disko disk configuration [5]
- [X] home manager
- [X] fish shell
- [X] tailscale
- [ ] backups (either borg or restic)
- [ ] Neovim-centric
- [ ] [agenix](https://github.com/ryantm/agenix) for secrets management (maybe [sops-nix](https://github.com/Mic92/sops-nix))
- [X] Wayland / Hyprland (needs more configuration but is there)
  - [X] Wofi
  - [X] Waybar
  - [X] Dunst

[1]: https://github.com/nix-community/impermanence
[2]: https://grahamc.com/blog/erase-your-darlings/
[3]: https://xeiaso.net/blog/paranoid-nixos-2021-07-18/
[4]: https://github.com/nix-community/impermanence?tab=readme-ov-file#btrfs-subvolumes
[5]: https://www.youtube.com/watch?v=YPKwkWtK7l0

# Partitions
For systems I can partition, I will follow Misterio77's config (linked in references)'s philosphy of:
- A single btrfs partition
  - `/nix` subvolume
  - `/persist` subvolume for impermanence [1]
  - `/` subvolume (cleared on every boot)
- 512 MB boot partition, using `systemd-boot`

Swap is handled by zram.

# Hosts
These are the devices I run NixOS on. I typically name my devices after elements on the periodic table.

## Uranium
A desktop computer I built in August of 2023. It runs any game I throw at it, an Intel i7-13700k (not overclocked) does well
in compiling things, so not much more I can ask for. This is where most of my development is done, however I do want to move
to a more laptop-first setup to encourage myself to step away from my office more frequently.

## Tungsten
My Dell XPS 15 9520 laptop. It served me *extremely* well during college. It does get a little hot and is a little
large and overkill for my current needs, so I'd like to eventually replace it. Current contenders are either a
[frame.work](https://frame.work) laptop or an M-series Macbook *(Air likely, maybe Pro?)*.

**TODO:** There are 2x1TB NVME SSDs in here, I never really use much space on it so maybe RAID would be beneficial here.

## Helium (`01` and `02`)
These are a pair of Intel NUC8i5BEK's that I use for a homelab. I intend to get another NUC or a Raspberry Pi
to experiment with [HA](https://en.wikipedia.org/wiki/High_availability), but not really my current priority.

Currently I run my services on Docker containers reverse-proxied together by Nginx Proxy Manager, however I want
to try a few more things like:
- Caddy
- K3s and helm

One of the NUCs has 32 GB of RAM, while the other has 16 GB. Each has a 2 TB NVMe SSD for storage.

Services ran:
- Forgejo (and subsequently deploy runners to both NUCs and my desktop)
- Immich
- Paperless-ngx
- Maybe
- Glance
- Vaultwarden
- A couple of Minecraft servers

**TODO:** Setup wake on LAN for these servers!

# References
*Also see numbered references in the Goals section*.
- [Misterio77's config](https://github.com/Misterio77/nix-config)
- [Ian Hengry's blog](https://ianthehenry.com/posts/)
- [Henrik Lissner's config](https://github.com/hlissner/dotfiles)
- [LongerHV's config](https://github.com/LongerHV/nixos-configuration)
- [gvolpe's config](https://github.com/gvolpe/nix-config)
- [workflow's dotfiles](https://github.com/workflow/dotfiles)
- [basic setup forom JackTheMico](https://github.com/JackTheMico/nixos-impermanent)
- [another small blog on nixos](https://guekka.github.io/)
- [Impermanence what to save command](https://www.reddit.com/r/NixOS/comments/1d1apm0/comment/l5tgbwz/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) `sudo fd --one-file-system --base-directory / --type f --hidden --exclude "{tmp,etc/passwd}"`
