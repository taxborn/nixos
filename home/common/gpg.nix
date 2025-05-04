{ hostname, ... }:

{
  programs.keychain = {
    enable = true;
    enableFishIntegration = true;
    agents = [
      "ssh"
      "gpg"
    ];
    extraFlags = [
      "--quiet"
    ];
    keys = [
      "${hostname}"
      "9BC40CD3E8BA5EF2"
    ];
  };

  home.file.".gpg/gpg-agent.conf".text = ''
    default-cache-ttl 84000
    max-cache-ttl 84000
  '';

  home.file.".gpg/gpg.conf".text = ''
    keyid-format LONG
  '';
}
