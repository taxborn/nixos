# taxborn's [NixOS](https://nixos.org) configuration
I've touched on NixOS here and there over the past 2 years or so. For the most part it has been great,
aside from the oddities surrounding it's non-[FHS](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)
compliance and a few other things mostly hindered by my lack of understanding. This is my attempt at making
a somewhat sensible configuration that I can deploy to my laptop(s), desktop, and homelab.

# Goals, features, wishlist?
- [ ] Impermanent [1] [2] [3]
- [ ] btrfs
- [ ] disko disk configuration
- [ ] home manager
- [ ] tailscale
- [ ] backups (either borg or restic)
- [ ] Neovim-centric
- [ ] Wayland / Hyprland
  - [ ] Wofi
  - [ ] Waybar
  - [ ] Dunst

# Hosts
These are the devices I run NixOS on. I typically name my devices after elements on the periodic table.

## Uranium
A desktop computer I built in August of 2023. It runs any game I throw at it, an Intel i7-13700k (not overclocked) does well
in compiling things, so not much more I can ask for.

## Tungsten
My Dell XPS 15 9520 laptop. Served me *extremely* well during college. It does get a little hot and is a little
large and overkill for my current needs, so I'd like to eventually replace it. Current contenders are either a
[frame.work](https://frame.work) laptop or an M-series Macbook *(Air likely, maybe Pro?)*.

## Helium (`01` and `02`)
These are a pair of Intel NUC8i5BEK's that I use for a homelab. I intend to get another NUC or a Raspberry Pi
to experiment with [HA](https://en.wikipedia.org/wiki/High_availability), but not really my current priority.

Currently I run my services on Docker containers reverse-proxied together by Nginx Proxy Manager, however I want
to try a few more things like:
- Caddy
- K3s and helm

One of the NUCs has 32 GB of RAM, while the other has 16 GB. Each has a 2 TB NVMe SSD for storage.

[1]: https://github.com/nix-community/impermanence
[2]: https://grahamc.com/blog/erase-your-darlings/
[3]: https://xeiaso.net/blog/paranoid-nixos-2021-07-18/
