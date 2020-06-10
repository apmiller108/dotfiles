(defun my/debug-hubble-vue ()
  (interactive) 
  (dap-debug (list :type "chrome"
                   :cwd nil
                   :mode "url"
                   :request "launch"
                   :webRoot "/Users/apmiller/dev/apps/hubble/client-vue/src"
                   :sourceMapPathOverrides (list :webpack:///src/* "${webRoot}/*"
                                                 :webpack:///./src/* "${webRoot}/*"
                                                 :webpack:///src/* "${webRoot}/*"
                                                 :webpack:///* "*"
                                                 :webpack:///./~/* "${webRoot}/node_modules/*")
                   :url "https://hubble-vue.dev.cmmint.net/"
                   :name "Chrome Hubble Vue")))

(defun my/debug-vue ()
  (interactive) 
  (dap-debug (list :type "chrome"
                   :cwd nil
                   :mode "url"
                   :request "launch"
                   :webRoot "/Users/apmiller/dev/apps/hubble/client-vue/src"
                   :sourceMapPathOverrides (list :webpack:///src/* "${webRoot}/*"
                                                 :webpack:///./src/* "${webRoot}/*"
                                                 :webpack:///src/* "${webRoot}/*"
                                                 :webpack:///* "*"
                                                 :webpack:///./~/* "${webRoot}/node_modules/*")
                   :url "https://hubble-vue.dev.cmmint.net/"
                   :name "Chrome Hubble Vue")))
