(setq user-full-name "vikigenius"
      user-mail-address "master.bvik@gmail.com")

(setq-default
  delete-by-moving-to-trash t                      ; Delete files to trash
  window-combination-resize t                      ; take new window space from all other windows (not just current)
  x-stretch-cursor t)                              ; Stretch cursor to the glyph width

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

(setq
 web-mode-css-indent-offset 2
 css-indent-offset 2)

(setq
 lua-indent-nested-block-content-align nil
 lua-indent-close-paren-align nil)
(defun rgc-lua-at-most-one-indent (old-function &rest arguments)
  (let ((old-res (apply old-function arguments)))
    (if (> old-res 2) 2 old-res)))

(advice-add #'lua-calculate-indentation-block-modifier
            :around #'rgc-lua-at-most-one-indent)

(set-file-template! 'python-mode :trigger "utf8")
(setq
 flycheck-python-mypy-config nil
 poetry-tracking-strategy 'switch-buffer
 pyenv-mode-mode-line-format ""
 python-indent-def-block-scale 1
 ;; lsp-pylsp-server-command '("poetry" "run" "pylsp")
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
              (setq my/flycheck-local-cache '((lsp . ((next-checkers . (python-flake8 python-mypy)))))))))
;; (add-hook 'python-mode-hook 'set-newline-and-indent)

(setq rustic-indent-offset 4
  lsp-rust-analyzer-proc-macro-enable t)

(use-package! jsonnet-mode
  :defer t
  :config
  (set-electric! 'jsonnet-mode :chars '(?\n ?: ?{ ?}))
  (setq jsonnet-use-smie t))

(setq json-reformat:indent-width 2) ;; Only for json not for jsonnet

(setq web-mode-markup-indent-offset 2
      web-mode-code-indent-offset 2
      typescript-indent-level 2)

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

  ;;;(setq lsp-diagnostic-filter 'my/filter-typescript )
  (setf (alist-get 'web-mode lsp--formatting-indent-alist) 'web-mode-code-indent-offset))

(define-derived-mode vue-mode web-mode "Vue"
  "A major mode derived from web-mode, for editing .vue files with LSP support.")
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(defun vue-setup()
  (when (modulep! :tools lsp)
    (lsp!)
    (setq lsp-vetur-validation-template nil)))

(add-hook 'vue-mode-hook #'vue-setup)

(defadvice! --nxml-electric-slash-remove-duplicate-right-angle-and-indent (func arg)
  :around 'nxml-electric-slash
  (let ((point-before (point)))
    (funcall func arg)
    (unless (equal (+ 1 point-before) (point))
      (delete-char 1)
      (funcall indent-line-function))))

(setq org-cite-global-bibliography (expand-file-name "~/Library/Documents/My Library.bib")
      org-cite-csl-styles-dir (expand-file-name "~/.local/share/zotero/styles")
      citar-bibliography (expand-file-name "~/Library/Documents/My Library.bib")
      citar-file-parser-functions '(citar-file--parser-default citar-file--parser-triplet))

(setq ispell-dictionary "en_US")

(define-key input-decode-map [?\C-i] [C-i])
(map! :i "<C-i>" #'doom/dumb-indent)

(setq org-directory "~/Library/Documents/Org/"
      org-agenda-files (list "~/Library/Documents/Org/Agenda"))
(with-eval-after-load 'org-roam
    (add-hook! 'after-save-hook
           (defun org-rename-to-new-title ()
             (when-let*
                 ((old-file (buffer-file-name))
                  (is-roam-file (org-roam-file-p old-file))
                  (file-node (save-excursion
                               (goto-char 1)
                               (org-roam-node-at-point)))
                  (slug (org-roam-node-slug file-node))
                  (new-file (expand-file-name (concat slug ".org")))
                  (different-name? (not (string-equal old-file new-file))))
               (rename-buffer new-file)
               (rename-file old-file new-file)
               (set-visited-file-name new-file)
               (set-buffer-modified-p nil)))))
(setq org-roam-database-connector 'sqlite-builtin)
