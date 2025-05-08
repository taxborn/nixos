{ ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      help.autocorrect = "prompt";
      commit.verbose = true;
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      core.excludesfile = "~/.gitignore";
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      pull.rebase = false; # TODO: one day, set to true, when i'm brave enough
    };

    userName = "Braxton Fair";
    userEmail = "hello@taxborn.com";

    signing = {
      key = "9BC40CD3E8BA5EF2";
      signByDefault = true;
    };
  };

  home.file.".gitignore".text = ''
    .env
  '';
}
