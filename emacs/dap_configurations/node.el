(dap-register-debug-template
 "Mocha Docker Hubble Vue"
 (list :type "node"
       :request "attach"
       :port 32779
       :address "localhost"
       :restart nil
       :sourceMaps: nil
       :cwd nil
       :mode "url"
       :remoteRoot "/app/client-vue/"
       :localRoot "/Users/apmiller/dev/apps/hubble/client-vue/"
       :name "Mocha Docker Hubble Vue"))

(require 'dap-node)
(dap-register-debug-template
 "Mocha Current File"
 (list :type "node"
       :request "launch"
       :cwd "/Users/upgraydd/development/javascript/vuejs/space/"
       :program "/Users/upgraydd/development/javascript/vuejs/space/node_modules/@vue/cli-service/bin/vue-cli-service.js"
       :args (list "test:unit" "--inspect-brk" "--watch" "--timeout" "999999")
       :port 9229
       :console "integratedTerminal"
       ;; :sourceMaps t
       ;; :outFiles (list "webpack:///./tests/unit/store/modules/ships.spec.js")
       ;; :internalConsoleOptions "neverOpen"
       ;; :runtimeVersion "7.8.0"
       ;; :runtimeExecutable "/usr/local/bin/node"
       :name "Mocha Current File"))
