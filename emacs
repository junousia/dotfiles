;;; Wrapper to make .emacs self-compiling.
(defvar init-top-level t)
(if init-top-level
  (progn
    ;; Toggle window dedication
    (defun toggle-window-dedicated ()
      (interactive)
      (message
       (if (let (window (get-buffer-window (current-buffer)))
             (set-window-dedicated-p window (not (window-dedicated-p window))))
           "Window '%s' is dedicated" "Window '%s' is normal")
       (current-buffer)))
    ;;Then bind it to some key - I use the Pause key:
    (global-set-key [pause] 'toggle-window-dedicated)
    
    (defun goto-match-paren (arg)
      "Go to the matching  if on (){}[], similar to vi style of % "
      (interactive "p")
      ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
      (cond ((looking-at "[\[\(\{]") (forward-sexp))
            ((looking-back "[\]\)\}]" 1) (backward-sexp))
            ;; now, try to succeed from inside of a bracket
            ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
            ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
            (t nil)))

    (global-set-key [f12] 'goto-match-paren) 

    (setq warning-suppress-types nil)

    ;; ============================
    ;; IBuffer filter groups
    ;; ============================
    (require 'ibuffer) 
    (setq ibuffer-saved-filter-groups
      (quote (("default"      
            ("BGF"
             (or
              (filename . "/proj/mgwrepos/user/ejuknou/mmgw/bgf_appl/")
              (filename . "/proj/mgwrepos/user/ejuknou/mmgw/bgf_common/")
              ))
            ("Framework common"
             (filename . "/proj/mgwrepos/user/ejuknou/mmgw/framework_common/"))
            ("MGW"
             (filename . "/proj/mgwrepos/user/ejuknou/mmgw/"))
            ("Others users"
              (filename . "/proj/mgwrepos/user/"))
            ("General"
              (or
                (mode . c-mode)
                (mode . c++-mode)
                (mode . perl-mode)
                (mode . python-mode)
                (mode . emacs-lisp-mode)
                )) 
            ))))

    (add-hook 'ibuffer-mode-hook
      (lambda ()
        (ibuffer-switch-to-saved-filter-groups "default")))

    ;; ============================
    ;; Switch between header and implementation
    ;; ============================
    (add-hook 'c-mode-common-hook
              (lambda()
                (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

    (add-to-list 'load-path "~/.elisp/")

    ;; ===========================
	;; Sr-Speedbar
    ;; ===========================
    (require 'sr-speedbar)

    ;; ============================
    ;; TTCN-3 mode
    ;; ============================
    (require 'ttcn3-bds)

    ;; ============================
    ;; Set Git path
    ;; ============================
    (setq exec-path (append exec-path '("/app/mgw/git/1.7.8.3/bin/")) )

    ;; ============================
    ;; Set default font
    ;; ============================
    (set-face-attribute 'default nil :font "DejaVu Sans Mono-12")

    ;; ============================
    ;; Hide stuff
    ;; ============================
    ;; (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)

    ;; ============================
    ;; Display
    ;; ============================
    (setq column-number-mode t)

    ;; ============================
    ;; Meta key
    ;; ============================
    (setq x-alt-keysym 'meta)

    ;; ==========================
    ;; Scroll one line at a time
    ;; ==========================
    (setq scroll-step 1)

    ;; ==========================
    ;; Tabs
    ;; ==========================
    ;; set default auto intend to 4 spaces
    ;; Note! intend for modes have to be set seperately
    (setq tab-width 4)
    (setq-default indent-tabs-mode nil)
    (setq c-hungry-delete-key t)

    ;; ==========================
    ;; C/C++ indentation
    ;; ==========================
    (defun my-c-mode-common-hook ()
      (turn-on-font-lock)
      (c-set-style "stroustrup"))

    (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

    ;; =========================
    ;; IBuffer
    ;; =========================
    (global-set-key (kbd "C-x C-b") 'ibuffer)

    ;; =========================
    ;; Global key shortcuts
    ;; =========================
    (global-set-key [f1] 'manual-entry)
    (global-set-key [f2] 'cscope-pop-mark)
    (global-set-key [f3] 'cscope-find-this-text-string)
    (global-set-key [f4] 'cscope-find-called-functions)
    (global-set-key [f5] 'cscope-find-global-definition-no-prompting)
    (global-set-key [f6] 'cscope-find-this-symbol)
    (global-set-key [f7] 'cscope-find-functions-calling-this-function)
    (global-set-key [f8] 'cscope-find-files-including-file)
    (global-set-key [f9] 'cscope-find-egrep-pattern)

    ;; =========================
    ;; Move text 
    ;; =========================
    (require 'move-text)
    (global-set-key [M-up] 'move-text-up)
    (global-set-key [M-down] 'move-text-down)

    ;; =========================
    ;; IDO mode
    ;; =========================
    (ido-mode)

    ;;  Display the time on the status bar
    ;;(setq display-time-24hr-format t)
    ;;(display-time)

    ;; ============================
    ;; cscope
    ;; ============================
    (require 'xcscope)

    ;; ============================
    ;; Color theme
    ;; ============================
    (require 'color-theme)
    (color-theme-initialize)
    (color-theme-dark-laptop)

    ;; follow cursor in shell mode
    ;;(auto-show-make-point-visible t)

    ;; server
    (server-start)

    ;; scrollbar
    (toggle-scroll-bar -1)
    (winner-mode 1)

    ;; save session
    (desktop-save-mode 1)

    ;; disable startup message
    (setq inhibit-startup-message t)

    ;; always truncate
    (setq-default truncate-partial-width-windows t)
    (setq-default truncate-lines t)
    (setq kill-whole-line t)
    (setq query-replace-highlight t)

    ;disable backup
    (setq backup-inhibited t)

    ;disable auto save
    (setq auto-save-default nil)

    ;; =========================
    ;; Code completion
    ;; =========================
    (load-file "~/.elisp/cedet-configuration.el")

    ;; =========================
    ;; yasnippet
    ;; =========================
    (add-to-list 'load-path "~/.elisp/yasnippet-0.7.0")
    (require 'yasnippet)
    (yas/initialize)
    (yas/load-directory "~/.elisp/yasnippet-0.7.0/snippets")
    (global-set-key [f11] 'yas/insert-snippet)

;;;; Wrapper to make .emacs self-compiling end
    )
  )

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-revert-check-vc-info t)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.bmk")
 '(bookmark-bmenu-toggle-filenames nil)
 '(cc-search-directories (quote ("." "/usr/include" "/usr/local/include/*" "../inc" "../include" "../src" "../../inc" "../../src")))
 '(column-number-mode nil)
 '(cscope-allow-arrow-overlays t)
 '(cscope-display-cscope-buffer t)
 '(cscope-display-times nil)
 '(cscope-edit-single-match t)
 '(cscope-name-line-width -20)
 '(cscope-no-mouse-prompts t)
 '(cscope-truncate-lines t)
 '(cscope-use-face t)
 '(cua-mode t nil (cua-base))
 '(global-auto-revert-mode t)
 '(global-auto-revert-non-file-buffers t)
 '(ibuffer-always-compile-formats t)
 '(ibuffer-always-show-last-buffer t)
 '(ibuffer-display-summary nil)
 '(ibuffer-elide-long-columns t)
 '(ibuffer-formats (quote ((mark modified read-only " " (name 35 35 :left :elide) " " (mode 8 8 :left :elide) " " filename-and-process) (mark " " (name 30 -1) " " filename))))
 '(ibuffer-old-time 12)
 '(ibuffer-show-empty-filter-groups nil)
 '(ibuffer-use-header-line nil)
 '(ido-enable-flex-matching t)
 '(ido-enable-regexp t)
 '(ido-everywhere t)
 '(menu-bar-mode 0)
 '(mouse-wheel-progressive-speed t)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 1) ((control)))))
 '(show-paren-mode t)
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
