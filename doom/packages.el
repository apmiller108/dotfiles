;; -*- no-byte-compile: t; -*-
;;; ~doom/packages.el

;; Additional packages not included in Doom modules
(package! editorconfig)
(package! color-theme-sanityinc-tomorrow)
(package! sqlite3)
(package! zeal-at-point)
(package! xclip)
(package! groovy-mode)
(package! nginx-mode)
(package! csv-mode)
(package! vue-mode)
(package! copilot
          :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
(package! gptel)
(package! ox-gfm)  ; GitHub Flavored Markdown export for org
(package! mermaid-mode)
(package! ob-mermaid)
