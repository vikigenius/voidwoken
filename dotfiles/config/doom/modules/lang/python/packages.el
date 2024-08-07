;; -*- no-byte-compile: t; -*-
;;; lang/python/packages.el

;; Major modes
(package! pip-requirements :pin "216cd1690f80cc965d4ae47b8753fc185f778ff6")
(when (modulep! +cython)
  (package! cython-mode :pin "3e4790559d3168fe992cf2aa62f01423038cedb5")
  (when (modulep! :checkers syntax)
    (package! flycheck-cython :pin "ecc4454d35ab5317ab66a04406f36f0c1dbc0b76")))

;; LSP
(when (modulep! +lsp)
  (unless (modulep! :tools lsp +eglot)
    (cond ((modulep! +pyright)
           (package! lsp-pyright :pin "2f2631ae242d5770dbe6cb924e44c1ee5671789d"))
          ((modulep! +basedpyright)
           (package! lsp-basedpyright :recipe (:host github :repo "vikigenius/lsp-basedpyright")))
          (t (package! lsp-python-ms :pin "7bda327bec7b219d140c34dab4b1e1fbd41bc516")))))

;; Programming environment
(package! pyvenv :pin "31ea715f2164dd611e7fc77b26390ef3ca93509b")

(package! anaconda-mode :pin "efd42aa8736d855a3c95e06e6daf4aa797290a93")
(when (modulep! :completion company)
  (package! company-anaconda :pin "dabc0adc9a0e56357e046de5fd4dbd8fc797e542"))

(when (modulep! +rye)
  (package! rye :recipe (:host github :repo "vikigenius/rye-mode")))

(when (modulep! +conda)
  (package! conda :pin "60e14d1e9793431b91913a5688e278bd91d56224"))

;; Testing frameworks
(package! nose :pin "f8528297519eba911696c4e68fa88892de9a7b72")
(package! python-pytest :pin "bdfb3e81eedc6b76ed0c5f77079e7cc8adff7b00")

;; Import managements
(package! pyimport :pin "c006a5fd0e5c9e297aa2ad71b2f02f463286b5e3")
(package! py-isort :pin "e67306f459c47c53a65604e4eea88a3914596560")
