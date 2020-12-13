;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;
;; Email
(setq +notmuch-sync-backend 'mbsync-xdg)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Flycheck
;;
(after! flycheck
  (setq
   doom-modeline-checker-simple-format nil
   flycheck-idle-change-delay 10
   flycheck-check-syntax-automatically '(mode-enabled save idle-change)))
  ;;(flycheck-add-mode 'javascript-eslint 'vue-mode))

(defun set-newline-and-indent ()
  "Map the return key with `newline-and-indent'"
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'python-mode-hook 'set-newline-and-indent)

(after! python
  (setq python-indent-def-block-scale 1))


(setq org-directory "~/Library/Documents/org/")
(setq org-agenda-files (list "~/Library/Documents/org/Agenda"))

(defun my-python-noindent-docstring (&optional _previous)
  (if (eq (car (python-indent-context)) :inside-docstring)
      'noindent))

;; (advice-add 'python-indent-line :before-until #'my-python-noindent-docstring)
;; Use C-v TAB to manually insert TAB


(set-file-template! 'python-mode :trigger "utf8")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      packages          ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! jsonnet-mode
  :defer t
  :config
  (set-electric! 'jsonnet-mode :chars '(?\n ?: ?{ ?})))

(use-package! ox-ipynb
  :after ox)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      keybindings       ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key input-decode-map [?\C-i] [C-i])
(map! :i "<C-i>" #'doom/dumb-indent)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Vue JS            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun doom-private-setup-vue ()
  ;;(setq-local lsp-diagnostics-provider :none)
  (lsp!)
  ;; Remove this if you get eslint working simultaneuously
  ;; TODO: https://github.com/emacs-lsp/lsp-mode/issues/2244
  (electric-indent-local-mode -1))
(define-derived-mode vue-mode web-mode "Vue"
  "A major mode derived from web-mode, for editing .vue files with LSP support.")
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
;;(add-hook 'vue-mode-local-vars-hook #'doom-private-setup-vue)


(setq lsp-eslint-server-command
   '("node"
     "/home/void/.vscode-oss/extensions/dbaeumer.vscode-eslint-2.1.8/server/out/eslintServer.js"
     "--stdio"))

(setq lsp-eslint-run "onSave")
;;(add-hook 'vue-mode-hook #'eglot-ensure)
;;(after! eglot
;;  (add-to-list 'eglot-server-programs '(vue-mode "vls")))

;; Appearance
(defun doom-private-setup-org ()
  (interactive)
  (electric-indent-local-mode -1))

(setq
 doom-theme 'doom-dracula
 doom-font "Source Code Pro:pixelsize=16:antialias=true:autohint=true"
 doom-variable-pitch-font (font-spec :family "Arvo" :style "Regular")
 org-hide-emphasis-markers t)

(add-hook 'org-mode-hook #'doom-private-setup-org)

(custom-theme-set-faces! 'doom-dracula
  ;;`(font-lock-comment-face :foreground , (doom-darken 'yellow 0.5))
  `(markdown-code-face :background ,(doom-darken 'bg 0.075))
  `(font-lock-variable-name-face :foreground ,(doom-lighten 'magenta 0.6)))

(add-to-list 'doom-unicode-extra-fonts "icomoon" t)

;; Editor
(setq
 json-reformat:indent-width 2)
