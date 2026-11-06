{
  description = "CLI tools for the chezmoi-managed terminal environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in {
      packages = nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.buildEnv {
            name = "chezmoi-cli-tools";
            paths = with pkgs; [
              bash
              git
              git-lfs
              tmux
              neovim
              fzf
              ripgrep
              bat
              delta
              direnv
              fish
              fd
              lazygit
              tree-sitter
            ] ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.gcc ];
            pathsToLink = [ "/bin" "/share" ];
          };
        });
    };
}
