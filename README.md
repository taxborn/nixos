# My [nixos](https://nixos.org) configuration
... and dotfiles!

## Installing
It's pretty easy once you `git pull`. `cd` into the directory and execute:
```
sudo nixos-rebuild switch --flake .#<NAME>
```
where **<NAME>** can be either `turing` (my desktop) or `euclid` (my laptop) in my setup.

I've also set up an alias per-host of `rebuild` that can be executed anywhere in the system.

## Errors encountered
Say I added a new file or directory, then rebuilt and got this:
```
error: getting status of '/nix/store/na49w7mcc7352sbnlscilzp4sxf9a3nv-source/dotfiles/i3': No such file or directory
```
I need to do a `git add .`, good time to commit too.
