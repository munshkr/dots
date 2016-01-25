;;
;; Based on `init-basic.el` by Matthew Chan <matt@themattchan.com>
;; https://gist.github.com/112f4a71294aec281fa9.git
;; License: GNU GPL
;;

;;==============================================================================
;;  PRELIMINARIES
;;==============================================================================
;; packages for Emacs 24
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize))

;; tries to install +name+ package if it's not installed yet
(defun use-package (name)
  (unless (package-installed-p name)
	(package-install name)))

;; list of currently used packages
(use-package 'evil)
(use-package 'monokai-theme)
(use-package 'inf-ruby)
(use-package 'haskell-mode)
(use-package 'racket-mode)
(use-package 'geiser)
(use-package 'extempore-mode)
(use-package 'whitespace-cleanup-mode)
(use-package 'markdown-mode)
(use-package 'web-mode)

;; M-x customize-* settings location.
;; Create a custom.el file and set before using M-x customize, or else you
;; litter the init.el file

;; (setq custom-file "~/.emacs.d/custom-24.el")
;; (load custom-file)

;; your info here
(setq user-full-name "Damián Emiliano Silvani"
      user-mail-address "dsilvani@gmail.com")

(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-linux* (member system-type '(gnu gnu/linux gnu/kfreebsd)))

;;==============================================================================
;;  KEYBINDINGS
;;==============================================================================
;; fix modifier keys on Mac GUI (carbon emacs)
;; Assume caps is mapped to control
(setq
 ns-command-modifier 'meta              ; L command -> C
 ns-option-modifier 'meta               ; L option -> m
 ;; ns-control-modifier 'super          ; L control -> super
 ;; ns-function-modifier 'hyper         ; fn -> super
 ns-function-modifier 'super

 ;; right hand side modifiers
 ns-right-command-modifier 'super       ; R command -> super
 ns-right-option-modifier 'hyper        ; R option -> hyper
 )

(global-set-key (kbd "M-/") 'hippie-expand) ; replace default expand command

;;==============================================================================
;; STARTUP, UI, AND GENERAL SETTINGS
;;==============================================================================
;;------------------------------------------------------------------------------
;; Mac open new files in the existing frame
(setq ns-pop-up-frames nil)

;;------------------------------------------------------------------------------
;; Show time on the mode line
(display-time)

;;------------------------------------------------------------------------------
;; Kill UI cruft
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;; want menu bar only in guis, it's useless on the terminal anyways
(cond ((not window-system)
       (menu-bar-mode -1)))

;; No cursor blink
(blink-cursor-mode -1)

;;------------------------------------------------------------------------------
;; Load stuff
(eval-when-compile (require 'cl))
;;(load 'saveplace)                       ; save last loc in file
;;(load 'ffap)                            ; Finding Files and URLs at Point
;;(load 'uniquify)                        ; unique buffer titles
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; dired jump to current file dir with C-x C-j
(autoload 'dired-x "dired-x")

;;------------------------------------------------------------------------------
;; Completion modes, etc
;; Use ibuffer to list buffers by default
(defalias 'list-buffers 'ibuffer)

;; isearch buffer switching
(iswitchb-mode 1)
(icomplete-mode 1)

;; ido
(autoload 'ido "ido")

(ido-mode t)
(ido-everywhere 1)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t
      ido-use-faces nil)

;;------------------------------------------------------------------------------
;; Fix Emacs interface annoyances
;; Global settings for ALL BUFFERS
(setq-default
 ;;---------------------------;;
 ;; GLOBAL INTERFACE SETTINGS ;;
 ;;---------------------------;;

 ;; Kill the splash screen and all that garbage
 inhibit-splash-screen t
 inhibit-startup-message t
 inhibit-startup-screen t
 inhibit-startup-buffer-menu t
 initial-scratch-message ""
 menu-prompting nil
 ;confirm-kill-emacs 'y-or-n-p           ; Ask before exit - takes a while to load, y'know?
 confirm-kill-emacs nil

 display-warning-minimum-level 'error   ; Turn off annoying warning messages
 disabled-command-function nil          ; Don't second-guess advanced commands

 ;; Mode line customizations
 line-number-mode t
 column-number-mode t

 ;; Scrolling
 scroll-preserve-screen-position t      ; scrolling does not move cursor
 mouse-wheel-mode t                     ; use wheel
 echo-keystrokes 0.1

 redisplay-dont-pause t                 ; smooth scrolling
 scroll-margin 1
 scroll-step 1
 scroll-conservatively 10000
 scroll-preserve-screen-position 1
 mouse-wheel-follow-mouse 't
 mouse-wheel-scroll-amount '(1 ((shift) . 1))

 ;; Buffer handling
 save-place t
 save-place-forget-unreadable-files t
 uniquify-rationalize-file-buffer-names t
 uniquify-buffer-name-style 'forward
 buffers-menu-sort-function 'sort-buffers-menu-by-mode-then-alphabetically ; Buffers menu settings
 buffers-menu-grouping-function 'group-buffers-menu-by-mode-then-alphabetically
 buffers-menu-submenus-for-groups-p t
 ibuffer-default-sorting-mode 'filename/process

 ;; Syntax highlighting: font lock mode
 font-lock-use-fonts '(or (mono) (grayscale))    ; Maximal syntax highlighting
 font-lock-use-colors '(color)
 font-lock-maximum-decoration t
 font-lock-maximum-size nil
 font-lock-auto-fontify t

 ring-bell-function 'ignore             ; stfu and stop beeping. you ain't vim.

 ;;-------------------------;;
 ;; GLOBAL EDITING SETTINGS ;;
 ;;-------------------------;;

 ;; integrate with the system clipboard ffs
 x-select-enable-clipboard t
 ;; set initial major mode to be text
 initial-major-mode 'fundamental-mode
 ;; Increase number of undo
 undo-limit 1000
 ;; default fill-column is 80 chars
 fill-column 80
 ;; English spelling, thanks
 ;ispell-dictionary "english"

 ;; Tabs and indentation and whitespace
 ;; tabs to spaces by default
 indent-tabs-mode nil

 ;; Default tab display is 4 spaces
 tab-width 4

 ;; default insert is also 4 and inc of 4
 ;; got to specify this or it will continue to expand to 8 spc
 tab-stop-list (number-sequence 4 120 4)

 ;; highlight the whole expression when closing parens
 ;; show-paren-style 'expression

 ;; No newlines at end of buffer unless I press return
 next-line-add-newlines nil

 ;; sentences end with one space only.
 sentence-end-double-space nil

 ;; FORCE FILES TO BE UTF-8 and LF damn it
 buffer-file-coding-system        'utf-8-unix
 default-file-name-coding-system  'utf-8-unix
 default-keyboard-coding-system   'utf-8-unix
 default-process-coding-system    '(utf-8-unix . utf-8-unix)
 default-sendmail-coding-system   'utf-8-unix
 default-terminal-coding-system   'utf-8-unix

 ;; flyspell
 ;flyspell-issue-welcome-flag nil
 ;ispell-list-command "list"
 ) ;; end setq-default

;; Redefine startup messasge, replace the string with whatever you want
(defun startup-echo-area-message ()
  "Emacs ready.")

;; y/n prompts instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; normal delete key behaviour please
(delete-selection-mode t)               ; highlight selection and overwrite
(transient-mark-mode t)

;; line numbers
(autoload 'linum "linum-mode")
(eval-after-load "linum"
  ;; one space separation, even in terminal
  (setq linum-format "%d "))

;; Cleanup file on save
;(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Load theme
(load-theme 'monokai t)

;;------------------------------------------------------------------------------
;; Fonts (face) customization
(autoload 'faces "fonts")
(when (and (window-system) *is-a-mac*)
  (set-face-attribute 'default nil
                      :font "Monaco"
                      :height 120    ; default font size is 12pt on carbon emacs
                      :weight 'normal
                      :width 'normal))

(when (and (window-system) *is-linux*)
  (set-face-attribute 'default nil
                      :font "Monospace-10"
                      :height 100
                      :width 'normal))

;;------------------------------------------------------------------------------
;; No popups and dialogues. They crash carbon emacs.
;; Not to mention that they're incredibly annoying.
(defadvice y-or-n-p (around prevent-dialog activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
;; Fallback. DIE, DIALOGUE BOXES, DIE!!
(setq use-dialog-box nil)

;;------------------------------------------------------------------------------
;; File formatting. yuck crlf
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

;;------------------------------------------------------------------------------
;; flyspell - aspell is better
;(if *is-a-mac*
;    (setq-default ispell-program-name "/opt/local/bin/aspell")
;  (setq-default ispell-program-name "/usr/bin/aspell"))

(set-language-environment "UTF-8")

;;==============================================================================
;; PLAIN TEXT AND DOCUMENT MODES
;;==============================================================================
(add-hook 'text-mode-hook
          (lambda ()
            (linum-mode 0)
            (visual-line-mode 1)
            (setq
             ;; tabs to spaces in text mode
             indent-tabs-mode nil
             ;; Default tabs in text is 4 spaces
             tab-width 4
             ;; default insert is also 4 and inc of 4
             ;; got to specify this or it will continue to expand to 8 spc
             tab-stop-list (number-sequence 4 120 4)
             )
            ;; ask to turn on hard line wrapping
            (when (y-or-n-p "Hard wrap text?")
              (turn-on-auto-fill))))

;;==============================================================================
;; PROGRAMMING MODES
;;==============================================================================

;; autoload whitespace-mode if not loaded already
;; highlight 80+ char overflows in programming modes
(autoload 'whitespace-mode "whitespace" "whitespace-mode" t nil)

;; highlights, line numbers, etc, common to ALL PROGRAMMING MODES
;(add-hook 'prog-mode-hook 'ac-ispell-ac-setup)
(add-hook 'prog-mode-hook
          (lambda()
            (auto-fill-mode 1)
            (electric-indent-mode 1)    ; auto indent
            (linum-mode 1)
            (show-paren-mode 1)
            (hl-line-mode 1)
            (whitespace-mode)
            (subword-mode)

            (setq
             indent-tabs-mode nil
             ;; also, ensure that tabs are 4 spc wide unless specified
             tab-width 4

             show-paren-delay 0
             comment-multi-line t       ; enable multiline comments
             comment-auto-fill-only-comments t
             grep-highlight-matches t   ; grep in colour
             )))

;; no auto-indent
(defvar whitespace-langs
  '(python-mode
    yaml-mode
    haskell-mode
    literate-haskell-mode))
(dolist (mode whitespace-langs)
  (add-hook (intern (format "%s-hook" mode))
            (lambda ()
              (electric-indent-mode -1)
              (electric-pair-mode -1))))

;;------------------------------------------------------------------------------
;; Whitespace-mode setup

;; only show overflow space by default
(defvar only-trailing-whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook
          (lambda()
            (setq
             ;; highlight 80 char overflows
             whitespace-line-column 80
             whitespace-style only-trailing-whitespace-style)))

;; beautify whitespace chars
(setq whitespace-display-mappings
      '((space-mark 32 [183] [46])
        (newline-mark 10 [182 10])      ; pilcrow
        (tab-mark 9 [9655 9] [92 9])))

;; Toggle between overflow & all whitespace. To use: M-x toggle-whitespace-mode
;; adapted from https://github.com/expez/.emacs.d/blob/master/init-whitespace.el
(defvar whitespace-show-all-mode nil)
(defun* toggle-whitespace-mode ()
  "Toggles whitespace modes between modes where some whitespace
   is highligted and all whitespace is highlighted.
   With a prefix argument whitespace-mode is turned off.
   C-u <prefix> M-x toggle-whitespace-mode"

  (interactive)
  (when current-prefix-arg
    (if whitespace-mode
        (progn
          (whitespace-mode 0)
          (message "Whitespace mode off"))
      (whitespace-mode 1)
      (message "Whitespace mode on"))
    (return-from toggle-whitespace-mode))
  (if whitespace-show-all-mode
      (progn
        (setq whitespace-style only-trailing-whitespace-style)
        (setq whitespace-show-all-mode nil)
        (whitespace-mode 0)
        (whitespace-mode 1)
        (message "Highlighting overflow only"))
    (setq whitespace-style
          '(face tabs spaces trailing lines-tail space-before-tab newline
                 indentation empty space-after-tab space-mark tab-mark
                 newline-mark))
    (setq whitespace-show-all-mode t)
    (whitespace-mode 0)
    (whitespace-mode 1)
    (message "Highlighting all whitespace")))

;;------------------------------------------------------------------------------
;; C family common settings
;;------------------------------------------------------------------------------
;; cc-mode hooks in order:
;; 1. c-initialization-hook, init cc mode once per session (i.e. emacs startup)
;; 2. c-mode-common-hook, run immediately before loading language hook
;; 3. then language hooks:
;;    c, c++, objc, java, idl, pike, awk

(defun my-c-indent ()
  (setq
   ;; set correct backspace behaviour
   ;; c-backspace-function 'backward-delete-char
   ;; c-type lang specifics. want 4-space width tab tabs
   c-basic-offset 4
   c-indent-tabs-mode nil
   c-indent-level 4
   c-tab-always-indent t
   tab-width 4
   ;; use tabs, not spaces.
   indent-tabs-mode nil))

(add-hook 'c-initialization-hook
          (lambda ()
            (my-c-indent)             ; just to be sure
            (setq-default c-default-style '((c-mode     . "linux")
                                            (c++-mode   . "k&r")
                                            (java-mode  . "java")
                                            (awk-mode   . "awk")
                                            (other      . "free-group-style")))
            (add-to-list 'c-cleanup-list 'comment-close-slash)))

(add-hook 'c-mode-common-hook
          (lambda ()
            (my-c-indent)
            ;; subword editing and movement to deal with CamelCase
            (c-toggle-electric-state 1)
            (subword-mode 1)
            (c-toggle-auto-newline 1)
            ;; don't indent curly braces. gnu style is madness.
            (c-set-offset 'statement-case-open 0)
            (c-set-offset 'substatement-open 0)
            (c-set-offset 'comment-intro 0)))
;; Assembly
(add-hook 'asm-mode-hook
          (lambda ()
            (auto-complete-mode 0)
            (setq-local asm-comment-char ?\!)
            (setq-local tab-width 8)
            (setq-local tab-stop-list (number-sequence 8 120 8))
            (setq-local indent-tabs-mode nil)))

;; C
(autoload 'ac-c-headers "ac-c-headers")
(add-hook 'c-mode-hook
          (lambda ()
            (matt/c-indent)
            (add-to-list 'ac-sources 'ac-source-c-headers)
            (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))


;;==============================================================================
;; Miscellaneous
;;==============================================================================
(add-to-list 'load-path "~/src/Tidal")
(add-to-list 'load-path "~/rivulet")
;(add-to-list 'load-path "~/src/extempore/extras")

(require 'evil)
(evil-mode 1)

(require 'tidal)
(require 'rivulet)
;(require 'extempore)

;; Web mode
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)

(global-whitespace-cleanup-mode)
