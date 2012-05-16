;; CEDET configuration
(load-file "~/.elisp/cedet-1.1beta2/common/cedet.el")
(global-ede-mode 1)      ; Enable the Project management system
(setq ede-locate-setup-options '(ede-locate-global ede-locate-base)) 
 
;; uncomment out one of the following 3 lines for more or less semantic features
;;(semantic-load-enable-minimum-features)
;;(semantic-load-enable-code-helpers) 
(semantic-load-enable-excessive-code-helpers) 

;;enable folding mode to collapse a definition into a single line
;; (global-semantic-tag-folding-mode)
 
;; SRecode minor mode.
(global-srecode-minor-mode 1)
 
;; (semantic-idle-completions-mode 1)
(setq semantic-imenu-auto-rebuild-directory-indexes nil)
(ede-enable-generic-projects)
(require 'semantic-ia)
(require 'semantic-gcc)
;; gnu global support
(require 'semanticdb-global)
(require 'semanticdb)
(global-semanticdb-minor-mode 1)
(semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)
 
;; ctags
;;(require 'semanticdb-ectag)
;;(semantic-load-enable-primary-exuberent-ctags-support)

;;(semantic-complete-inline-analyzer-displayor-class 'semantic-displayor-tooltip)
;;(semantic-completion-displayor-format-tag-function 'semantic-format-tag-summarize)
 
;; customisation of modes
(defun my-cedet-hook ()
 (local-set-key [(control shift return)] 'semantic-ia-complete-symbol-menu)
 (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
 (local-set-key [(control .)] 'semantic-complete-analyze-inline)
 (local-set-key "\C-c=" 'semantic-decoration-include-visit)
 (local-set-key "\C-cj" 'semantic-ia-fast-jump)
 (local-set-key "\C-cb" 'semantic-mrub-switch-tags)
 (local-set-key "\C-cq" 'semantic-ia-show-doc)
 (local-set-key [(control ,)] 'semantic-ia-show-summary)
 (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
 (local-set-key "\C-cr" 'semantic-symref)
 ;; for senator
 ;;(local-set-key "\C-c\-" 'senator-fold-tag)
 ;;(local-set-key "\C-c\+" 'senator-unfold-tag)
 )
 
(add-hook 'semantic-init-hooks 'my-cedet-hook)
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'cpp-mode-common-hook 'my-cedet-hook)
;;(add-hook 'lisp-mode-hook 'my-cedet-hook)
;;(add-hook 'emacs-lisp-mode-hook 'my-cedet-hook)
;; (add-hook 'erlang-mode-hook 'my-cedet-hook)
 
(defun my-c-mode-cedet-hook ()
 (local-set-key "\C-ca" 'semantic-complete-analyze-inline)
 (local-set-key "\C-ct" 'eassist-switch-h-cpp)
 (local-set-key "\C-ce" 'eassist-list-methods)
)
 
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

(ede-cpp-root-project "M-MGW"
               :name "M-MGW Git"
               :file "/proj/mgwrepos/user/ejuknou/mmgw/del_to_cc.tcsh"
               :include-path '("/")
               :system-include-path '("/usr/include/"
                                      "/usr/include/c++/4.1.2"))


