{ lib, config, ... }:
{

  options.cargo = {
    pre-commit = {
      cargo-lock.enable = lib.mkEnableOption (lib.mdDoc "cargo lock check in pre-commit hook") // {
        default = true;
      };
      cargo-fmt.enable = lib.mkEnableOption (lib.mdDoc "cargo fmt check in pre-commit hook") // {
        default = true;
      };
    };
  };


  config = lib.mkMerge [
    (lib.mkIf
      config.cargo.pre-commit.cargo-lock.enable
      {
        git.pre-commit.hooks = {
          cargo_lock = ''
            # https://users.rust-lang.org/t/check-if-the-cargo-lock-is-up-to-date-without-building-anything/91048/5
            cargo update --workspace --locked
          '';
        };
      })

    (lib.mkIf
      config.cargo.pre-commit.cargo-fmt.enable
      {
        git.pre-commit.hooks = {
          cargo_fmt = ''
            cargo fmt --all --check
          '';
        };
      })
  ];
}
