;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Org
(setq org-roam-directory "~/slip-box") ;; sets org-roam dir
(setq org-roam-db-location "~/slip-box/db/org-roam.db")
(setq org-roam-tag-sources '(prop vanilla))
(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
        :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                          "#+title: ${title}\n#+date: %<%Y-%m-%d %H:%M %p>\n#+updated: \n")
        :unnarrowed t)
        ("c" "cmm" plain "%?"
        :target (file+head "cmm/%<%Y%m%d%H%M%S>-${slug}.org"
                          "#+title: ${title}\n")
        :unnarrowed t)
        ("p" "personal" plain "%?"
        :target (file+head "personal/%<%Y%m%d%H%M%S>-${slug}.org"
                          "#+title: ${title}\n#+date: %<%Y-%m-%d %H:%M %p>\n#+updated: \n")
        :unnarrowed t)
        ("l" "local" plain "%?"
        :target (file+head "local/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
        :unnarrowed t)))
(setq org-roam-node-display-template
      (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

;; VueJS
(add-hook 'vue-mode-hook #'lsp!)

;; Ivy
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

;; dap
(defvar my/dap-debug-url nil)
(defvar my/dap-debug-project-root nil)

(defun my/dap-debug-determine-project-root ()
  (or my/dap-debug-project-root (projectile-project-root)))

;; Vitest

(defun my/vitest-run-current-unit-test ()
  (interactive)
  (compile
   (concat
    (cond (my/run-js-tests-in-docker
           (concat "docker exec " my/docker-container-name " ./node_modules/vitest/vitest.mjs "))
          (t
           (concat "cd " (my/dap-debug-determine-project-root) " && " "./node_modules/vitest/vitest.mjs ")))
    "run "
    (file-relative-name buffer-file-name my/dap-debug-project-root))
   t))
