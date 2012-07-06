;; CEDET configuration
(add-to-list 'load-path "~/.elisp/cedet-1.1/common/")
(require 'cedet)

;;(setq semantic-load-turn-useful-things-on t)
(global-ede-mode 1)      ; Enable the Project management system
(setq ede-locate-setup-options '(ede-locate-global ede-locate-base))


 
;; uncomment out one of the following 3 lines for more or less semantic features
;;(semantic-load-enable-minimum-features)
;;(semantic-load-enable-code-helpers) 
(semantic-load-enable-excessive-code-helpers) 

;;enable folding mode to collapse a definition into a single line
;;(global-semantic-tag-folding-mode)
 
;; SRecode minor mode.
(global-srecode-minor-mode 1)
(ede-enable-generic-projects)

(require 'semantic-ia)
(require 'semantic-gcc)
;; gnu global support
(require 'semanticdb)
(global-semanticdb-minor-mode 1)

(require 'semanticdb-ectag)
(semantic-load-enable-all-exuberent-ctags-support)
(semanticdb-enable-exuberent-ctags 'c-mode)
(semanticdb-enable-exuberent-ctags 'c++-mode)
(setq-mode-local cpp-mode semanticdb-find-default-throttle 

                 '(project local unloaded system recursive))


(setq cedet-cscope-command "/home/ejuknou/bin/cedet-cscope")
(setq cedet-global-command "/home/ejuknou/bin/global")
(setq cedet-global-gtags-command "/home/ejuknou/bin/gtags")

(setq semantic-idle-work-parse-neighboring-files-flag nil)
(setq global-semantic-idle-completions-mode nil)
(setq semantic-ia-completion-menu-format-tag-function (quote semantic-format-tag-concise-prototype))
(setq semantic-idle-summary-function (quote semantic-format-tag-prototype))
(setq semantic-which-function-use-color t)
(global-semantic-decoration-mode nil)

;; customisation of modes
(defun my-cedet-hook ()
  (local-set-key [(control shift return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key [(control .)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cb" 'semantic-mrub-switch-tags)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key [(control -)] 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-cr" 'semantic-symref)
  (local-set-key [(C-S-mouse-1)] 'semantic-ia-fast-mouse-jump)
  (local-set-key [(C-M-mouse-1)] 'find-tag)
  (local-set-key [(C-M-mouse-3)] 'pop-tag-mark)
)
 
;;(add-hook 'semantic-init-hooks 'my-cedet-hook)
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'cpp-mode-common-hook 'my-cedet-hook)
(add-hook 'lisp-mode-hook 'my-cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'my-cedet-hook)
(add-hook 'erlang-mode-hook 'my-cedet-hook)
 
(defun my-c-mode-cedet-hook ()
 (local-set-key "\C-ct" 'eassist-switch-h-cpp)
 (local-set-key "\C-ce" 'eassist-list-methods)
)
 
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

(load-file "~/.elisp/projects.el")
