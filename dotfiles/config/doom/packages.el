;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
;; (package! lsp-mode :recipe (:host github :repo "vikigenius/lsp-mode" :branch "flake8"))
;; (package! flycheck :recipe (:host github :repo "vikigenius/flycheck" :branch "flake8config"))
;; (package! flycheck :recipe (:host github :repo "flycheck/flycheck" :branch "use-flake8rc-working-directory"))
(package! jsonnet-mode :recipe (:host github :repo "mgyucht/jsonnet-mode"))
(package! ox-ipynb :recipe (:host github :repo "jkitchin/ox-ipynb"))
;; (package! lsp-mode :recipe (:local-repo "lsp-mode" :no-byte-compile t))
;; (unpin! lsp-mode)

;; (package! lsp-mode :recipe (:host github :repo "yyoncho/lsp-mode" :branch "diag-filter"))
(unpin! lsp-mode)
(unpin! lsp-ui)
