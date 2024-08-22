# programs/neovim/custom-plugins.nix

{ pkgs, ... }:

{
  render-markdown-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "render-markdown-vim";
    src = pkgs.fetchFromGitHub {
      owner = "MeanderingProgrammer";
      repo = "render-markdown.nvim";
      rev = "v6.1.0";
      sha256 = "0akb89m0228lmws2iry30av1jnrd4w2pfq4rhandvcwpiaj7cqiz";
    };
  };
  
  # ...
}
