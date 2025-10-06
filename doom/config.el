;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Personal Information
(setq user-full-name "Alex Miller"
      user-mail-address "")

;; ============================================================================
;; APPEARANCE
;; ============================================================================

(setq doom-theme 'doom-one)  ; or 'doom-molokai, 'doom-tomorrow-night
(setq doom-font (font-spec :family "Menlo" :size 14)
      doom-variable-pitch-font (font-spec :family "Menlo" :size 14))

;; Line numbers
(setq display-line-numbers-type t)

;; Disable current line highlighting
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

;; Visual line mode globally
(global-visual-line-mode 1)

;; Emoji support
(set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

;; ============================================================================
;; EDITOR SETTINGS
;; ============================================================================

;; Disable lockfiles
(setq create-lockfiles nil)

;; Fill column
(setq-default fill-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; Whitespace
(setq-default whitespace-style '(face trailing)
              whitespace-line-column 80)

;; Mouse scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed t
      mouse-wheel-follow-mouse t
      scroll-step 1)

;; Frame resizing
(setq frame-resize-pixelwise t)

;; Warning level
(setq warning-minimum-level :error)

;; Process output
(setq read-process-output-max (* 1024 1024 2)) ; 2mb for LSP

;; Native comp warnings (Emacs 28+)
(setq native-comp-async-report-warnings-errors nil)

;; ============================================================================
;; INDENTATION SETTINGS
;; ============================================================================

(setq css-indent-offset 2
      json-encoding-default-indentation 2
      javascript-indent-level 2
      js-indent-level 2
      js2-mode-show-strict-warnings nil
      typescript-indent-level 2
      web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2
      web-mode-attr-indent-offset 2
      sh-basic-offset 2
      sh-indentation 2)

;; ============================================================================
;; ORG MODE
;; ============================================================================

(after! org
        (setq org-directory "~/slip-box/"
              org-agenda-files '("~/slip-box/personal/agenda")
              org-agenda-start-with-log-mode t
              org-log-done 'time
              org-log-into-drawer t
              org-image-actual-width nil
              org-hide-emphasis-markers t
              org-plantuml-jar-path (expand-file-name "~/plantuml.jar"))

        ;; Org file apps
        (setq org-file-apps
              '((auto-mode . emacs)
                (directory . emacs)
                ("\\.png\\'" . default)
                ("\\.jpe?g\\'" . default)
                ("\\.mm\\'" . default)
                ("\\.x?html?\\'" . default)
                ("\\.pdf\\'" . default)
                ("\\.docx\\'" . default)))

        ;; Org mode hooks
        (add-hook 'org-mode-hook
                  (lambda ()
                    (setq-local time-stamp-active t
                                time-stamp-start "#\\+updated: [ \t]*"
                                time-stamp-end "$"
                                time-stamp-format "%Y-%m-%d %H:%M %p")
                    (add-hook 'before-save-hook 'time-stamp nil 'local)
                    (set-face-underline 'org-ellipsis nil)
                    (auto-fill-mode 1)))

        ;; Load ox-gfm for GitHub Flavored Markdown export
        (require 'ox-gfm nil t))

;; ============================================================================
;; ORG-ROAM
;; ============================================================================

(after! org-roam
        (setq org-roam-directory "~/slip-box"
              org-roam-db-location "~/slip-box/db/org-roam.db"
              org-roam-tag-sources '(prop vanilla))

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
              (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag))))

;; ============================================================================
;; LSP MODE
;; ============================================================================

(after! lsp-mode
        (setq lsp-signature-auto-activate nil)

        ;; Ruby LSP configuration
        (add-hook 'lsp-mode-hook
                  (lambda ()
                    (when (memq major-mode '(ruby-mode enh-ruby-mode))
                      (add-to-list 'lsp-disabled-clients 'ruby-ls)
                      (add-to-list 'lsp-disabled-clients 'rubocop-ls)
                      (flycheck-add-next-checker 'lsp 'ruby-rubocop)))))

;; Vue/Volar configuration
(after! lsp-volar
        (lsp-dependency 'typescript
                        '(:npm :package "typescript"
                               :path "tsserver")))

;; ============================================================================
;; LANGUAGE-SPECIFIC SETTINGS
;; ============================================================================

;; JavaScript/TypeScript
(add-hook 'js2-mode-hook #'rainbow-mode)
(add-hook 'typescript-mode-hook #'rainbow-mode)

;; Vue
(after! vue-mode
        (add-hook 'vue-mode-hook
                  (lambda ()
                    (flycheck-add-mode 'javascript-eslint 'vue-mode))))

;; Ruby
(after! ruby-mode
        (setq rbenv-installation-dir "/usr/local/"))

;; RSpec
(after! rspec-mode
        (setq rspec-use-spring-when-possible nil)
        ;; Override spring detection for Docker compatibility
        (defun rspec-spring-p () rspec-use-spring-when-possible))

;; ============================================================================
;; COPILOT
;; ============================================================================

(use-package! copilot
              :hook (prog-mode . copilot-mode)
              :bind (:map copilot-completion-map
                          ("M-<up>" . 'copilot-accept-completion)
                          ("M-<right>" . 'copilot-accept-completion-by-word)
                          ("M-<down>" . 'copilot-accept-completion-by-line)))

;; ============================================================================
;; GPTEL (LLM Client)
;; ============================================================================

(use-package! gptel
              :config
              (setq gptel-model "gpt-4"
                    gptel-default-mode 'org-mode))

;; ============================================================================
;; MAGIT
;; ============================================================================

(after! magit
        (setq magit-repository-directories
              '(("~/dev/" . 0)
                ("~/dev/apps/" . 1)
                ("~/code/" . 1)
                ("~/dotfiles/" . 0))))

;; ============================================================================
;; COMPILATION
;; ============================================================================

;; ANSI color support in compilation buffers
(require 'ansi-color)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; ============================================================================
;; TREE-SITTER
;; ============================================================================

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (org "https://github.com/tree-sitter/tree-sitter-org")
        (ruby "https://github.com/ikatyang/tree-sitter-ruby")
        (scss "https://github.com/ikatyang/tree-sitter-scss")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (vue "https://github.com/ikatyang/tree-sitter-vue")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; ============================================================================
;; CUSTOM FUNCTIONS
;; ============================================================================

;; DAP Debug variables
(defvar my/dap-debug-url nil)
(defvar my/dap-debug-project-root nil)
(defvar my/rspec-last-command nil)
(defvar my/kube-namespace nil)
(defvar my/kube-container nil)
(defvar my/docker-container-name nil)
(defvar my/run-js-tests-in-docker nil)

(defun my/dap-debug-determine-project-root ()
  (or my/dap-debug-project-root (projectile-project-root)))

;; Chrome debugging
(defun my/dap-debug-chrome ()
  (interactive)
  (require 'dap-chrome)
  (dap-debug (list :type "chrome"
                   :cwd (or my/dap-debug-project-root (projectile-project-root))
                   :mode "url"
                   :request "launch"
                   :userDataDir: nil
                   :localRoot (my/dap-debug-determine-project-root)
                   :remoteRoot (concat my/dap-debug-url "v2/")
                   :webRoot (my/dap-debug-determine-project-root)
                   :url (or my/dap-debug-url "http://localhost:8080")
                   :name "Chrome Javascript Debug Config")))

;; Mocha debugging
(defun my/dap-debug-mocha-vue ()
  (interactive)
  (require 'dap-node)
  (dap-debug (list :type "node"
                   :request "launch"
                   :console "internalConsole"
                   :env (list :NODE_ENV "test")
                   :cwd (or my/dap-debug-project-root (projectile-project-root))
                   :program (concat (my/dap-debug-determine-project-root)
                                    "node_modules/@vue/cli-service/bin/vue-cli-service.js")
                   :args (list "test:unit" "--inspect-brk" "--watch" "--timeout" "999999"
                               "--include" "tests/setup.js" (buffer-file-name))
                   :port 9229
                   :name "Node Mocha Current File")))

;; Vitest debugging
(defun my/dap-debug-vitest ()
  (interactive)
  (require 'dap-node)
  (require 'cl-lib)
  (cl-loop for buffer in (buffer-list)
           when (string-prefix-p "*Vitest Current File" (buffer-name buffer))
           do (kill-buffer buffer))
  (dap-debug (list :type "node"
                   :request "launch"
                   :console "integratedTerminal"
                   :autoAttachChildProcesses t
                   :smartStep t
                   :cwd (or my/dap-debug-project-root (projectile-project-root))
                   :program (concat (my/dap-debug-determine-project-root)
                                    "node_modules/vitest/vitest.mjs")
                   :args (list "run" (file-relative-name buffer-file-name
                                                         my/dap-debug-project-root))
                   :port 9229
                   :name "Vitest Current File")))

;; Run Vitest tests
(defun my/run-current-vuejs-unit-test ()
  (interactive)
  (compile
   (concat
    (cond (my/run-js-tests-in-docker
           (concat "docker exec " my/docker-container-name
                   " ./node_modules/vitest/vitest.mjs "))
          (t
           (concat "cd " (my/dap-debug-determine-project-root)
                   " && " "./node_modules/vitest/vitest.mjs ")))
    "run "
    (file-relative-name buffer-file-name my/dap-debug-project-root))
   t))

;; ESLint fix
(defun my/eslint-fix ()
  (interactive)
  (shell-command
   (concat (my/dap-debug-determine-project-root)
           "node_modules/.bin/eslint --fix " (buffer-file-name))))

;; ESLint check buffer
(defun my/eslint-check-buffer ()
  "Run eslint on current buffer"
  (interactive)
  (compile
   (concat
    (my/dap-debug-determine-project-root)
    "node_modules/.bin/eslint "
    (buffer-file-name))
   t))

;; TypeScript checker setup
(defun my/setup-typescript-mode-checkers ()
  "Adds eslint as the next flycheck checker to lsp"
  (interactive)
  (flycheck-add-next-checker 'lsp '(warning . javascript-eslint)))

;; RSpec Kubernetes functions
(defun my/rspec-k8s-cmd (file options)
  (setq my/rspec-last-command
        (concat "kubectl exec -it $(kubectl get pods -o=jsonpath='{range .items..metadata}{.name}{\"\\n\"}{end}' -n "
                my/kube-namespace
                " | fgrep --color=never "
                my/kube-container
                " | head -n1) -n "
                my/kube-namespace
                " -- bash -c 'bundle exec "
                (if rspec-use-spring-when-possible "spring " "")
                "rspec "
                file
                "'"))
  my/rspec-last-command)

(defun my/rspec-verify-k8s ()
  "Run the specs in the current buffer"
  (interactive)
  (compile
   (my/rspec-k8s-cmd (file-relative-name buffer-file-name my/dap-debug-project-root) "")
   t))

(defun my/rspec-verify-single-k8s ()
  "Run the specs at point in the current buffer"
  (interactive)
  (compile
   (my/rspec-k8s-cmd
    (concat (file-relative-name buffer-file-name my/dap-debug-project-root)
            ":"
            (number-to-string (line-number-at-pos)))
    "")
   t))

(defun my/rspec-rerun-k8s ()
  "Re-run the last RSpec command"
  (interactive)
  (if (not my/rspec-last-command)
      (error "No last command to run")
    (compile my/rspec-last-command t)))

;; Utility functions
(defun my/super-highlight-region ()
  "Darken the region and lighten the selected text"
  (interactive)
  (set-face-attribute 'region nil :background "#666" :foreground "#ffffff"))

(defun unfill-region (beg end)
  "Unfill the region, joining text paragraphs into a single logical line."
  (interactive "*r")
  (let ((fill-column (point-max)))
    (fill-region beg end)))

(defun my/open-in-code ()
  (interactive)
  (call-process-shell-command
   (concat "code " "-a " (projectile-project-root) " " buffer-file-name) nil 0))

;; ============================================================================
;; KEY BINDINGS
;; ============================================================================

;; Org-roam
(map! :leader
      :desc "Find org-roam node" "n r f" #'org-roam-node-find)

;; Custom bindings
(map! :leader
      :prefix ("o" . "custom")
      :desc "Super highlight region" "h" #'my/super-highlight-region
      :desc "Fill region" "f" #'fill-region
      :desc "Unfill region" "u" #'unfill-region)

;; JavaScript/TypeScript bindings
(map! :after js2-mode
      :localleader
      :map js2-mode-map
      :prefix ("o" . "custom")
      :desc "Debug Chrome" "d" #'my/dap-debug-chrome
      :desc "Debug Mocha" "m" #'my/dap-debug-mocha-vue
      :desc "Debug Vitest" "v" #'my/dap-debug-vitest
      :desc "Run test" "t" #'my/run-current-vuejs-unit-test
      :desc "ESLint fix" "e" #'my/eslint-fix
      :desc "ESLint check" "l" #'my/eslint-check-buffer)

(map! :after typescript-mode
      :localleader
      :map typescript-mode-map
      :prefix ("o" . "custom")
      :desc "Setup checkers" "c" #'my/setup-typescript-mode-checkers
      :desc "Debug Mocha" "m" #'my/dap-debug-mocha-vue
      :desc "Debug Vitest" "v" #'my/dap-debug-vitest
      :desc "Run test" "t" #'my/run-current-vuejs-unit-test
      :desc "ESLint fix" "e" #'my/eslint-fix)

;; Vue bindings
(map! :after vue-mode
      :localleader
      :map vue-mode-map
      :prefix ("o" . "custom")
      :desc "Debug Chrome" "d" #'my/dap-debug-chrome
      :desc "ESLint fix" "e" #'my/eslint-fix
      :desc "ESLint check" "l" #'my/eslint-check-buffer)

;; Ruby bindings
(map! :after ruby-mode
      :localleader
      :map ruby-mode-map
      :prefix ("o" . "custom")
      :desc "RSpec verify k8s" "b" #'my/rspec-verify-k8s
      :desc "RSpec rerun k8s" "r" #'my/rspec-rerun-k8s
      :desc "RSpec single k8s" "t" #'my/rspec-verify-single-k8s)

;; ============================================================================
;; FILE ASSOCIATIONS
;; ============================================================================

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.json\\.erb\\'" . json-mode))

;; ============================================================================
;; COMPANY (AUTO-COMPLETION)
;; ============================================================================

(after! company
        (custom-set-faces
         '(company-tooltip-common
           ((t (:inherit company-tooltip :weight bold :underline nil))))
         '(company-tooltip-common-selection
           ((t (:inherit company-tooltip-selection :weight bold :underline nil))))))
