;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
(package! jsonnet-mode :recipe (:host github :repo "mgyucht/jsonnet-mode"))
(package! ox-ipynb :recipe (:host github :repo "jkitchin/ox-ipynb"))
(package! just-mode :recipe (:host github :repo "leon-barrett/just-mode.el"))
(package! lsp-biome :recipe (:host github :repo "vikigenius/lsp-biome" :branch "doomcompat"))


;; (package! emacsql :pin "c1a4407")
(unpin! lsp-mode)
(unpin! org-roam)
(unpin! apheleia)
