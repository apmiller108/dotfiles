(dap-register-debug-template
 "Mocha Docker"
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
       :name "Mocha Docker"))
