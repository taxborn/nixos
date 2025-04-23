# taxborn's [NixOS](https://nixos.org) configuration
I've touched on NixOS here and there over the past 2 years or so. For the most part it has been great,
aside from the oddities surrounding it's non-[FHS](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)
compliance and a few other things mostly hindered by my lack of understanding. This is my attempt at making
a somewhat sensible configuration that I can deploy to my laptop(s), desktop, and homelab.

# Goals, features, wishlist?
- [ ] Flakes
- [ ] Impermanent [1] [2] [3] [5]
- [ ] btrfs [4] [5]
- [ ] disko disk configuration [5]
- [ ] home manager
- [ ] tailscale
- [ ] backups (either borg or restic)
- [ ] Neovim-centric
- [ ] [agenix](https://github.com/ryantm/agenix) for secrets management (maybe [sops-nix](https://github.com/Mic92/sops-nix))
- [ ] Wayland / Hyprland
  - [ ] Wofi
  - [ ] Waybar
  - [ ] Dunst

[1]: https://github.com/nix-community/impermanence
[2]: https://grahamc.com/blog/erase-your-darlings/
[3]: https://xeiaso.net/blog/paranoid-nixos-2021-07-18/
[4]: https://github.com/nix-community/impermanence?tab=readme-ov-file#btrfs-subvolumes
[5]: https://www.youtube.com/watch?v=YPKwkWtK7l0

# Hosts
These are the devices I run NixOS on. I typically name my devices after elements on the periodic table.

## Uranium
A desktop computer I built in August of 2023. It runs any game I throw at it, an Intel i7-13700k (not overclocked) does well
in compiling things, so not much more I can ask for. This is where most of my development is done, however I do want to move
to a more laptop-first setup to encourage myself to step away from my office more frequently.

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
