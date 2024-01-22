# plugins.nix
{ pkgs }:
with pkgs.vimPlugins; [
  telescope-nvim
  awesome-vim-colorschemes
  comment-nvim
  nvim-tree-lua
  nvim-lspconfig
]
