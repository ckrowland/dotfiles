{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [
      epkgs.company
      epkgs.magit
      epkgs.monokai-theme
      epkgs.nixfmt
      epkgs.nix-mode
      epkgs.sudo-utils
      epkgs.wgsl-mode
      epkgs.zig-mode
    ];
    extraConfig = ''
      (add-hook 'after-init-hook 'global-company-mode)
      (add-hook 'wgsl-mode-hook 'eglot-ensure)
      (add-hook 'zig-mode-hook 'eglot-ensure)
      (column-number-mode 1)
      (global-set-key "\M-n" 'flymake-goto-next-error)
      (load-theme 'monokai t)
      (menu-bar-mode -1)
      (require 'sudo-utils)
      (savehist-mode 1)
      (setq standard-indent 4)
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      (with-eval-after-load 'eglot
          (add-to-list 'eglot-ignored-server-capabilities :inlayHintProvider)
          (add-to-list 'eglot-server-programs
             '(zig-mode . (
             "${pkgs.lib.getExe pkgs.zls}"
             :initializationOptions 
             (:enable_build_on_save t
              :zig_exe_path "${pkgs.lib.getExe pkgs.zig}"
             )))))
    '';
  };
}
