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

(after! flycheck
  (setq
   doom-modeline-checker-simple-format nil
   flycheck-idle-change-delay 10
   flycheck-check-syntax-automatically '(mode-enabled save idle-change)))

(setq
 lsp-idle-delay 0.5
 lsp-ui-sideline-delay 0.5)

(set-file-template! 'python-mode :trigger "utf8")
(setq
 poetry-tracking-strategy 'switch-buffer
 pyenv-mode-mode-line-format ""
 python-indent-def-block-scale 1
 lsp-pylsp-plugins-flake8-enabled nil
 lsp-pylsp-plugins-mccabe-enabled nil
 lsp-pylsp-plugins-pydocstyle-enabled nil)
(use-package! ox-ipynb :after ox)

(defvar-local my/flycheck-local-cache nil)

(defun my/flycheck-checker-get (fn checker property)
  (or (alist-get property (alist-get checker my/flycheck-local-cache))
      (funcall fn checker property)))

(advice-add 'flycheck-checker-get :around 'my/flycheck-checker-get)

(add-hook 'lsp-managed-mode-hook
          (lambda ()
            (when (derived-mode-p 'python-mode)
              (setq my/flycheck-local-cache '((lsp . ((next-checkers . (python-flake8)))))))))
;; (add-hook 'python-mode-hook 'set-newline-and-indent)

(setq rustic-indent-offset 4)

(use-package! jsonnet-mode
  :defer t
  :config
  (set-electric! 'jsonnet-mode :chars '(?\n ?: ?{ ?}))
  (setq jsonnet-use-smie t))

(setq json-reformat:indent-width 2) ;; Only for json not for jsonnet

(setq web-mode-markup-indent-offset 2
      web-mode-code-indent-offset 2)

(after! lsp-mode
  (lsp-defun my/filter-typescript ((params &as &PublishDiagnosticsParams :diagnostics)
                                   _workspace)
             (lsp:set-publish-diagnostics-params-diagnostics
              params
              (or (seq-filter (-lambda ((&Diagnostic :source? :code?))
                                (not (and (string= "typescript" source?)
                                          (string= "6133" (prin1-to-string code?)))))

                              diagnostics)
                  []))
             params)

  (setq lsp-diagnostic-filter 'my/filter-typescript )
  (setf (alist-get 'web-mode lsp--formatting-indent-alist) 'web-mode-code-indent-offset))

(define-derived-mode vue-mode web-mode "Vue"
  "A major mode derived from web-mode, for editing .vue files with LSP support.")
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(defun vue-setup()
  (when (featurep! :tools lsp)
    (lsp!)
    (setq lsp-vetur-validation-template nil)))

(add-hook 'vue-mode-hook #'vue-setup)

(setq ispell-dictionary "en_US")

(define-key input-decode-map [?\C-i] [C-i])
(map! :i "<C-i>" #'doom/dumb-indent)

(setq org-directory "~/Library/Documents/Org/")
(setq org-agenda-files (list "~/Library/Documents/Org/Agenda"))
