{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [
      epkgs.company
      epkgs.lsp-mode
      epkgs.magit
      epkgs.monokai-theme
      epkgs.nixfmt
      epkgs.nix-mode
      epkgs.wgsl-mode
      epkgs.zig-mode
    ];
    extraConfig = ''
      (load-theme 'monokai t)
      (menu-bar-mode -1)
      (savehist-mode 1)
      (scroll-bar-mode -1)
      (setq standard-indent 4)
      (setq lsp-zig-zls-executable "${pkgs.zls}/bin")
      (setq lsp-zig-zig-exe-path "${pkgs.zig}")
      (tool-bar-mode -1)
      (add-hook 'after-init-hook 'global-company-mode)
    '';
  };
}
