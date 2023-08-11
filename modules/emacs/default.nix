{ inputs, pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.emacs;
  lsp-bridge = builtins.fetchGit {
    url = "https://github.com/manateelazycat/lsp-bridge.git";
    rev = "d7dbd6ffca0d79493e084895d30df265453e21c9";
  };
  xfk = builtins.fetchGit {
    url = "https://github.com/xahlee/xah-fly-keys.git";
    rev = "5b566d51c78d0662f21b14752e71d2ab59775d96";
  };
  python = pkgs.python311.withPackages (ps: with ps; [
    epc
    orjson
    sexpdata
    paramiko
  ]);
in {
  options.modules.emacs.enable = mkEnableOption "emacs without spacemacs support";
  imports = [ ./emacs-init.nix ];
  
  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      python
      # language servers 
      nil
      nodePackages.pyright
    ];


    home.file.".emacs.d/lisp/lsp-bridge".source = lsp-bridge;
    home.file.".emacs.d/lisp/xah-fly-keys".source = xfk;
    
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-unstable.overrideAttrs (finalAttrs: previousAttrs: {
        withNativeComp = true;
        withTreeSitter = true;
      });
      

      init = {
        enable = true;

        recommendedGcSettings = true;

        prelude = let
          fontSize = if pkgs.stdenv.isDarwin then "15" else "14";
          emacsFont = ''
            (when window-system
              (set-frame-font "Hasklig ${fontSize}"))
          '';
        in emacsFont + ''
          (require 'bind-key)

          (setq inhibit-startup-screen t)

          (menu-bar-mode -1)

          (electric-pair-mode)

          (recentf-mode 1)
          (setq recentf-max-menu-items 25)
          (setq recentf-max-saved-items 25)
          (global-set-key "\C-x\ \C-r" 'recentf-open-files)

          (when window-system
            (dolist (mode
              '(tool-bar-mode
                tooltip-mode
                scroll-bar-mode
                menu-bar-mode
                blink-cursor-mode))
              (funcall mode 0)))

          (add-hook 'text-mode-hook 'auto-fill-mode)

          (setq delete-old-versions -1 )		; delete excess backup versions silently
          (setq version-control t )		; use version control
          (setq vc-make-backup-files t )		; make backups file even when in version controlled dir
          (setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
          (setq vc-follow-symlinks t )				       ; don't ask for confirmation when opening symlinked file
          (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
          (setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
          (setq ring-bell-function 'ignore )	; silent bell when you make a mistake
          (setq coding-system-for-read 'utf-8 )	; use utf-8 by default
          (setq coding-system-for-write 'utf-8 )
          (setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
          (setq default-fill-column 80)		; toggle wrapping text at the 80th character

          (defun chomp (str)
            "Chomp leading and tailing whitespace from STR."
            (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'"
                                str)
              (setq str (replace-match "" t t str)))
            str)
          (setq gofmt-command "goimports")
          (defun eshell/e (arg)
            "opens a given file in emacs from eshell"
            (find-file arg))

          (defun eshell/eh (arg)
            "opens a file in emacs from shell horizontally"
            (split-window-vertically)
            (other-window 1)
            (find-file arg))

          (defun eshell/ev (arg)
            "opens a file in emacs from shell vertically"
            (split-window-horizontally)
            (other-window 1)
            (find-file arg))

          (set-frame-parameter (selected-frame) 'alpha '(85 . 85))
          (add-to-list 'default-frame-alist '(alpha . (85 . 85)))

          (add-to-list 'load-path "~/.emacs.d/lisp/lsp-bridge")
          (require 'lsp-bridge)
          (global-lsp-bridge-mode)
          (setq lsp-bridge-nix-lsp-server 'nil)
          (add-hook 'direnv-envrc-mode-hook 'lsp-bridge-restart-process)


          (add-to-list 'load-path "~/.emacs.d/lisp/xah-fly-keys")
          (require 'xah-fly-keys)
          (xah-fly-keys-set-layout "dvorak")
          (xah-fly-keys 1) 
        '';

        usePackageVerbose = true;

        usePackage = {
          all-the-icons = {
            enable = true;
          };

          mood-line = {
            enable = true;
            config = ''
              (defun tj/project-relative-file-name (include-prefix)
              "Return the project-relative filename, or the full path if INCLUDE-PREFIX is t."
              (letrec
              ((fullname (if (equal major-mode 'dired-mode) default-directory (buffer-file-name)))
              (root (project-root (project-current)))
              (relname (if fullname (file-relative-name fullname root) fullname))
              (should-strip (and root (not include-prefix))))
              (if should-strip relname fullname)))

              (defun tj/mood-line-segment-project-advice (oldfun)
              "Advice to use project-relative file names where possible."
              (let
              ((project-relative (ignore-errors (tj/project-relative-file-name nil))))
              (if
              (and (project-current) (not org-src-mode) project-relative)
              (propertize (format "%s  " project-relative) 'face 'mood-line-buffer-name)
              (funcall oldfun))))

              (advice-add 'mood-line-segment-buffer-name :around #'tj/mood-line-segment-project-advice)
              (mood-line-mode)
            ''; 
          };

          company = {
            enable = false;
            diminish = [ "company-mode" ];
            config = ''
              (company-mode)
            '';
          };

          god-mode = {
            enable = false;
            config = ''
              (god-mode)
              (global-set-key (kbd "<escape>") #'god-mode-all)
              (setq god-exempt-major-modes nil)
              (setq god-exempt-predicates nil)
            '';
          };

          dockerfile-mode = { enable = true; };

          counsel = {
            enable = true;

            bindStar = {
              "M-x" = "counsel-M-x";
              "C-x C-f" = "counsel-find-file";
              "C-x C-r" = "counsel-recentf";
              "C-c f" = "counsel-git";
              "C-c s" = "counsel-git-grep";
              "C-c /" = "counsel-rg";
              "C-c l" = "counsel-locate";
              "M-y" = "counsel-yank-pop";
            };

            general = ''
              (general-nmap
                :prefix "SPC"
                "SPC" '(counsel-M-x :which-key "M-x")
                "ff"  '(counsel-find-file :which-key "find file")
                "s"   '(:ignore t :which-key "search")
                "sc"  '(counsel-unicode-char :which-key "find character"))
            '';
          };

          cython-mode = { enable = true; };

          direnv = {
            enable = true;
            config = ''
              (direnv-mode)
            '';
          };

          better-defaults.enable = true;

          ein = {
            enable = true;
          };

          pyvenv = {
            enable = true;
          };

          flycheck = {
            enable = true;
            diminish = [ "flycheck-mode" ];
            config = ''
              (global-flycheck-mode)
            '';
          };

          go-mode = { enable = true; };

          lsp-mode = {
            enable = false;
            command = [ "lsp" ];
            hook = [
              "(go-mode . lsp)"
              "(rust-mode . lsp)"
              "(lsp-mode . lsp-enable-which-key-integration)"
            ];
            config = ''
              (setq lsp-rust-server 'rust-analyzer)
            '';
          };

          general = {
            enable = true;
            after = [ "which-key" ];
            config = ''

              (general-create-definer my-leader-def
                :prefix "SPC")

              (general-create-definer my-local-leader-def
                :prefix "SPC m")

              (general-nmap
                :prefix "SPC"
                "b"  '(:ignore t :which-key "buffer")
                "bd" '(kill-this-buffer :which-key "kill buffer")

                "f"  '(:ignore t :which-key "file")
                "ff" '(find-file :which-key "find")
                "fs" '(save-buffer :which-key "save")

                "m"  '(:ignore t :which-key "mode")

                "t"  '(:ignore t :which-key "toggle")
                "tf" '(toggle-frame-fullscreen :which-key "fullscreen")
                "wv" '(split-window-horizontally :which-key "split vertical")
                "ws" '(split-window-vertically :which-key "split horizontal")
                "wd" '(delete-window :which-key "delete")

                "q"  '(:ignore t :which-key "quit")
                "qq" '(save-buffers-kill-emacs :which-key "quit"))
            '';
          };

          ivy = {
            enable = true;
            demand = true;
            diminish = [ "ivy-mode" ];
            config = ''
              (ivy-mode 1)
              (setq ivy-use-virtual-buffers t
                    ivy-hight 20
                    ivy-count-format "(%d/%d) "
                    ivy-initial-inputs-alist nil)
            '';
            general = ''
              (general-nmap
                :prefix "SPC"
                "bb" '(ivy-switch-buffer :which-key "switch buffer")
                "fr" '(ivy-recentf :which-key "recent file"))
            '';
          };

          magit = {
            enable = true;

            general = ''
              (general-nmap
                :prefix "SPC"
                "g" '(:ignore t :which-key "Git")
                "gs" 'magit-status)
            '';
          };

          markdown-mode = {
            enable = true;
            command = [ "markdown-mode" "gfm-mode" ];
            mode = [
              ''("README\\.md\\'" . gfm-mode)''
              ''("\\.md\\'" . markdown-mode)''
              ''("\\.markdown\\'" . markdown-mode)''
            ];
          };

          nix = { enable = true; };

          nix-mode = {
            enable = true;
            mode = [ ''"\\.nix\\'"'' ];
            bindLocal = { nix-mode-map = { "C-i" = "nix-indent-line"; }; };
          };

          nix-prettify-mode = {
            enable = true;
            config = ''
              (nix-prettify-global-mode)
            '';
          };

          nix-drv-mode = {
            enable = true;
            mode = [ ''"\\.drv\\'"'' ];
          };

          projectile = {
            enable = true;
            after = [ "ivy" ];
            diminish = [ "projectile-mode" ];
            config = ''
              (projectile-mode 1)
              (progn
                (setq projectile-enable-caching t)
                (setq projectile-require-project-root nil)
                (setq projectile-completion-system 'ivy)
                (add-to-list 'projectile-globally-ignored-files ".DS_Store"))
            '';
            general = ''
              (general-nmap
                :prefix "SPC"
                "p"  '(:ignore t :which-key "Project")
                "pf" '(projectile-find-file :which-key "Find in project")
                "pl" '(projectile-switch-project :which-key "Switch project"))
            '';
          };

          protobuf-mode = { enable = true; };

          swiper = {
            enable = true;

            bindStar = { "C-s" = "swiper"; };

            general = ''
              (general-nmap
                :prefix "SPC"
                "ss" '(swiper :which-key "swiper"))
            '';
          };

          which-key = {
            enable = true;
            diminish = [ "which-key-mode" ];
            config = ''
              (which-key-mode)
              (which-key-setup-side-window-right-bottom)
              (setq which-key-sort-order 'which-key-key-order-alpha
                    which-key-side-window-max-width 0.33
                    which-key-idle-delay 0.05)
            '';
          };

          gruvbox-theme = {
            enable = true;
            config = ''
              (setq custom-safe-themes t)
              (add-hook 'after-init-hook (lambda () (load-theme 'gruvbox t)))
            '';
          };

          yasnippet = {
            enable = true;
            config = ''
              (yas-global-mode 1)
            '';
          };

          dhall-mode = {
            enable = true;
            mode = [ ''"\\.dhall\\'"'' ];
          };

          moonscript = {
            enable = true;
            mode = [ ''"\\.moon\\'"'' ];
          };

          rust-mode = {
            enable = true;
            mode = [ ''"\\.rs\\'"'' ];
          };

          toml-mode = {
            enable = true;
            mode = [ ''"\\.toml\\'"'' ];
          };

          zig-mode = {
            enable = true;
            mode = [ ''"\\.zig\\'"'' ];
          };

          nov = {
            enable = true;
            mode = [ ''"\\.epub\\'"'' ];
          };

          web-mode = {
            enable = true;
            mode = [ ''"\\.html\\'"'' ''"\\.tmpl\\'"'' ];
          };

          ob.enable = true;
          org-download.enable = true;
          org.enable = true;
          org-mime.enable = true;
          org-pomodoro.enable = true;
          org-projectile.enable = true;

          systemd.enable = true;
          terraform-mode.enable = true;
        };
      };
    };
  };
}
