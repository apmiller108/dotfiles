;;; init.el -*- lexical-binding: t; -*-

(doom! :input

       :completion
       company           ; the ultimate code completion backend
       vertico           ; the search engine of the future

       :ui
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink cursor line after big motions
       ophints           ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       treemacs          ; a project drawer, like neotree but cooler
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows
       workspaces        ; tab emulation, persistence & separate workspaces

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       multiple-cursors  ; editing in many places at once
       snippets          ; my elves. They type so I don't have to

       :emacs
       dired             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       vterm             ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       (spell +aspell)     ; tasing you for misspelling mispelling
       grammar             ; tasing grammar mistake every you make

       :tools
       (debugger +lsp)          ; FIXME stepping through code, to help you add bugs
       direnv
       docker
       editorconfig      ; let someone else argue about tabs vs spaces
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       lsp               ; M-x vscode
       magit             ; a git porcelain for Emacs
       make              ; run make tasks from Emacs
       (ranger +deer)    ; making dired pretty [functional]
       tree-sitter       ; syntax and parsing, sitting in a tree...

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS

       :lang
       (cc +lsp +tree-sitter)         ; C > C++ == 1
       data              ; config/data formats
       emacs-lisp        ; drown in parentheses
       (javascript +lsp +tree-sitter)        ; all(hope(abandon(ye(who(enter(here))))))
       json              ; At least it ain't XML
       (markdown +grip)    ; writing docs for people to ignore
       (org +roam2 +pretty +present)               ; organize your plain life in plain text
       plantuml          ; diagrams for confusing people more
       python            ; beautiful is better than ugly
       (ruby +lsp +tree-sitter +rails)             ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       sh                ; she sells {ba,z,fi}sh shells on the C xor
       (web +lsp +tree-sitter)               ; the tubes
       yaml              ; JSON, but readable

       :email

       :app

       :config
       (default +bindings +smartparens))
