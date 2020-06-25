((js2-mode
  (flycheck-checker . javascript-eslint)
  (eval . (setq-local flycheck-javascript-eslint-executable
                      (concat (locate-dominating-file default-directory ".dir-locals.el")
                              "node_modules/.bin/eslint"))))
 (vue-mode
  (flycheck-checker . javascript-eslint)
  (eval . (setq-local flycheck-javascript-eslint-executable
                      (concat (locate-dominating-file default-directory ".dir-locals.el")
                              "node_modules/.bin/eslint"))))
 (nil
  (eval . (setq-local my/dap-debug-url "http://localhost:8080"))))
