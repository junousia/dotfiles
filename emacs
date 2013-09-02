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
    ;; Diff mode enhancements
    ;; ============================
    (add-hook 'diff-mode-hook
              (lambda () (diff-auto-refine-mode 1)))

    ;; ============================
    ;; IBuffer filter groups
    ;; ============================
    (require 'ibuffer)
    (setq ibuffer-saved-filter-groups
      (quote (("default"
            ("BGF APPL"
             (or
              (filename . "/repo/ejuknou/mmgw/bgf_appl/")
              (filename . "/repo/ejuknou/mmgw/bgf_common/")
              ))
            ("Framework common"
             (filename . "/repo/ejuknou/mmgw/framework_common/"))
            ("VPP DP"
             (filename . "/repo/ejuknou/mmgw/bgf_vpp/blocks/vpi/"))
            ("VPP NP FPL"
             (filename . "/repo/ejuknou/mmgw/bgf_vpp/blocks/vpfp/src/fpl/"))
            ("VPP NP"
             (filename . "/repo/ejuknou/mmgw/bgf_vpp/blocks/vpfp/"))
            ("VPP DPCI"
             (filename . "/repo/ejuknou/mmgw/bgf_vpp/blocks/vpch/"))
            ("VPP General"
             (filename . "/repo/ejuknou/mmgw/bgf_vpp/"))
            ("MGW"
             (filename . "/repo/ejuknou/mmgw/"))
            ("Others users"
              (filename . "/repo/"))
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

    (add-to-list 'load-path "~/.elisp/")
    (when (load "flymake" t)
        (require 'flymake-cursor)
        (defun flymake-cppcheck-init ()
        (list "cppcheck" (list "--enable=all" "--quiet" "--template={file}:{line}:{severity}:{message}" (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))))
        (add-to-list 'flymake-allowed-file-name-masks
            '("\\.c\\'" flymake-cppcheck-init))
        (add-to-list 'flymake-allowed-file-name-masks
            '("\\.cc\\'" flymake-cppcheck-init))
        (add-to-list 'flymake-allowed-file-name-masks
            '("\\.cpp\\'" flymake-cppcheck-init))
        (add-to-list 'flymake-allowed-file-name-masks
            '("\\.h\\'" flymake-cppcheck-init))
        (add-to-list 'flymake-allowed-file-name-masks
            '("\\.hpp\\'" flymake-cppcheck-init))
        (add-to-list 'flymake-allowed-file-name-masks
            '("\\.hh\\'" flymake-cppcheck-init))
    )

    ;; ============================
    ;; Grep
    ;; ============================
    (eval-after-load "compile"
      '(defun compilation-goto-locus (msg mk end-mk)
         "Jump to an error corresponding to MSG at MK.
All arguments are markers.  If END-MK is non-nil, mark is set there
and overlay is highlighted between MK and END-MK."
         ;; Show compilation buffer in other window, scrolled to this error.
         (let* ((from-compilation-buffer (eq (window-buffer (selected-window))
                                             (marker-buffer msg)))
                ;; Use an existing window if it is in a visible frame.
                (pre-existing (get-buffer-window (marker-buffer msg) 0))
                (w (if (and from-compilation-buffer pre-existing)
                       ;; Calling display-buffer here may end up (partly) hiding
                       ;; the error location if the two buffers are in two
                       ;; different frames.  So don't do it if it's not necessary.
                       pre-existing
                     (let ((display-buffer-reuse-frames t)
                           (pop-up-windows t))
                       ;; Pop up a window.
                       (display-buffer (marker-buffer msg)))))
                (highlight-regexp (with-current-buffer (marker-buffer msg)
                                    ;; also do this while we change buffer
                                    (compilation-set-window w msg)
                                    compilation-highlight-regexp)))
           ;; Ideally, the window-size should be passed to `display-buffer' (via
           ;; something like special-display-buffer) so it's only used when
           ;; creating a new window.
           (unless pre-existing (compilation-set-window-height w))

           (switch-to-buffer (marker-buffer mk))

           ;; was
           ;; (if from-compilation-buffer
           ;;     ;; If the compilation buffer window was selected,
           ;;     ;; keep the compilation buffer in this window;
           ;;     ;; display the source in another window.
           ;;     (let ((pop-up-windows t))
           ;;       (pop-to-buffer (marker-buffer mk) 'other-window))
           ;;   (if (window-dedicated-p (selected-window))
           ;;       (pop-to-buffer (marker-buffer mk))
           ;;     (switch-to-buffer (marker-buffer mk))))
           ;; If narrowing gets in the way of going to the right place, widen.
           (unless (eq (goto-char mk) (point))
             (widen)
             (goto-char mk))
           (if end-mk
               (push-mark end-mk t)
             (if mark-active (setq mark-active)))
           ;; If hideshow got in the way of
           ;; seeing the right place, open permanently.
           (dolist (ov (overlays-at (point)))
             (when (eq 'hs (overlay-get ov 'invisible))
               (delete-overlay ov)
               (goto-char mk)))

           (when highlight-regexp
             (if (timerp next-error-highlight-timer)
                 (cancel-timer next-error-highlight-timer))
             (unless compilation-highlight-overlay
               (setq compilation-highlight-overlay
                     (make-overlay (point-min) (point-min)))
               (overlay-put compilation-highlight-overlay 'face 'next-error))
             (with-current-buffer (marker-buffer mk)
               (save-excursion
                 (if end-mk (goto-char end-mk) (end-of-line))
                 (let ((end (point)))
                   (if mk (goto-char mk) (beginning-of-line))
                   (if (and (stringp highlight-regexp)
                            (re-search-forward highlight-regexp end t))
                       (progn
                         (goto-char (match-beginning 0))
                         (move-overlay compilation-highlight-overlay
                                       (match-beginning 0) (match-end 0)
                                       (current-buffer)))
                     (move-overlay compilation-highlight-overlay
                                   (point) end (current-buffer)))
                   (if (or (eq next-error-highlight t)
                           (numberp next-error-highlight))
                       ;; We want highlighting: delete overlay on next input.
                       (add-hook 'pre-command-hook
                                 'compilation-goto-locus-delete-o)
                     ;; We don't want highlighting: delete overlay now.
                     (delete-overlay compilation-highlight-overlay))
                   ;; We want highlighting for a limited time:
                   ;; set up a timer to delete it.
                   (when (numberp next-error-highlight)
                     (setq next-error-highlight-timer
                           (run-at-time next-error-highlight nil
                                        'compilation-goto-locus-delete-o)))))))
           (when (and (eq next-error-highlight 'fringe-arrow))
             ;; We want a fringe arrow (instead of highlighting).
             (setq next-error-overlay-arrow-position
                   (copy-marker (line-beginning-position)))))))

    ;; ============================
    ;; Switch between header and implementation
    ;; ============================
    (add-hook 'c-mode-common-hook
              (lambda()
                (local-set-key  (kbd "C-c o") 'ff-find-other-file)))


    ;; ===========================
	;; Sr-Speedbar
    ;; ===========================
    (require 'sr-speedbar)

    ;; ============================
    ;; Show trailing whitespace
    ;; ============================
    (setq-default show-trailing-whitespace t)

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
    ;;(load-file "~/.elisp/cedet-configuration.el")
;;    (add-to-list 'load-path "~/.elisp/auto-complete")
;;    (add-to-list 'load-path "~/.elisp/auto-complete-clang-async")
;;    (add-to-list 'load-path "~/.elisp/auto-complete/lib/fuzzy")
;;    (add-to-list 'load-path "~/.elisp/auto-complete/lib/popup")
;;    (add-to-list 'load-path "~/.elisp/auto-complete/lib/ert")
;;    (require 'auto-complete-clang-async)

;;    (defun ac-cc-mode-setup ()
;;        (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
;;        (setq ac-sources '(ac-source-clang-async))
;;        (ac-clang-launch-completion-process)
;;    )

;;    (defun my-ac-config ()
;;        (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;;        (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;;        (global-auto-complete-mode t)
;;    )

;;    (my-ac-config)

    ;; =========================
    ;; yasnippet
    ;; =========================
    (add-to-list 'load-path "~/.elisp/yasnippet-0.7.0")
    (require 'yasnippet)
    (yas/initialize)
    (yas/load-directory "~/.elisp/yasnippet-0.7.0/snippets")
    (global-set-key [f11] 'yas/insert-snippet)

    ;; ========================
    ;; FIC mode (TODO etc.)
    ;; ========================
    (require 'fic-mode)
    (add-hook 'c++-mode-hook 'turn-on-fic-mode)
    (add-hook 'c-mode-common-hook 'turn-on-fic-mode)

    (add-to-list 'load-path "~/.elisp/vc-clearcase-3.7")
    (require 'vc-clearcase)

    (byte-recompile-directory (expand-file-name "~/.dotfiles") 0)

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
 '(diff-jump-to-old-file t)
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
 '(diff-added ((t (:inherit diff-changed :foreground "green"))))
 '(diff-changed ((nil (:foreground "yellow"))))
 '(diff-context ((((class color grayscale) (min-colors 88)) nil)))
 '(diff-file-header ((((class color) (min-colors 88) (background dark)) (:foreground "light sea green" :weight bold))))
 '(diff-function ((t (:inherit diff-header :foreground "LightSkyBlue"))))
 '(diff-header ((((class color) (min-colors 88) (background dark)) nil)))
 '(diff-index ((t (:inherit diff-file-header))))
 '(diff-indicator-added ((t (:inherit diff-added :foreground "green yellow"))))
 '(diff-indicator-changed ((t (:inherit diff-changed :foreground "yellow2"))))
 '(diff-indicator-removed ((t (:inherit diff-removed :foreground "red"))))
 '(diff-refine-change ((((class color) (min-colors 88) (background dark)) (:background "grey20"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "red3"))))
)
