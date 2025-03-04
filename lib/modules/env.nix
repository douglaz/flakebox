{ lib, config, ... }:
let
  inherit (lib) types;
in
{
  options.env = {
    shellPackages = lib.mkOption {
      type = types.listOf types.package;
      description = lib.mdDoc ''
        Packages to include in all dev shells
      '';
      default = [ ];
    };

    shellHooks = lib.mkOption {
      type = types.listOf types.str;
      description = lib.mdDoc ''
        List of init hooks to execute when shell is entered
      '';
      default = [ "" ];
    };

  };

  config = {
    rootDir.".config/flakebox/shellHook.sh" = {
      text = ''
        #!/usr/bin/env bash
      '' + builtins.concatStringsSep "\n" config.env.shellHooks;
    };
  };
}
