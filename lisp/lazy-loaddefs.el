;;; lazy-loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "compile-dwim" "../lazy/compile-dwim.el" (24656
;;;;;;  39456 514109 442000))
;;; Generated autoloads from ../lazy/compile-dwim.el

(defvar compile-dwim-alist `((mxml (or (name . "\\.mxml$")) (compile-dwim-make) "firefox %n.swf") (objc (mode . objc-mode) compile-dwim-xcode:build compile-dwim-xcode:build-and-run) (lua (or (name . "\\.lua$") (mode . lua-mode)) "lua %n.lua" "lua %n.lua") (go (name . "_test\\.go$") "go test" compile-go-test-current) (go (or (name . "\\.go$") (mode . go-mode)) (compile-dwim-make) "go run %n.go") (as (or (name . "\\.as$") (mode . actionscript-mode)) (compile-dwim-make) "firefox %n.swf") (asm (or (name . "\\.s$") (mode . asm-mode)) "as -o %n.o %f;ld -o %n %n.o " "./%n") (erlang (or (name . "\\.erl$") (mode . erlang-mode)) (erlang-dired-emake) "erl  \"%f\"") (perl (or (name . "\\.pl$") (mode . cperl-mode)) "%i -wc \"%f\"" "%i \"%f\"") (csharp (or (name . "\\.cs$") (mode . csharp-mode)) "csc %f" "%n") (c (or (name . "\\.c$") (mode . c-mode)) "gcc -o %n %f" ,(if (equal system-type 'windows-nt) "%n" "./%n")) (c++ (or (name . "\\.cpp$") (mode . c++-mode)) ("g++ -o %n %f" "g++ -g -o %n %f") ,(if (equal system-type 'windows-nt) "%n" "./%n") "%n") (java (or (name . "\\.java$") (mode . java-mode)) "javac %f" "java %n" "%n.class") (python (or (name . "\\.py$") (mode . python-mode)) "python %f" "python %f") (javascript (or (name . "\\.js$") (mode . javascript-mode)) "smjs -f %f" "smjs -f %f") (tex (or (name . "\\.tex$") (name . "\\.ltx$") (mode . tex-mode) (mode . latex-mode)) "latex %f" "latex %f" "%n.dvi") (texinfo (name . "\\.texi$") (makeinfo-buffer) (makeinfo-buffer) "%.info") (sh (or (name . "\\.sh$") (mode . sh-mode)) "sh ./%f" "sh ./%f") (f99 (name . "\\.f90$") "f90 %f -o %n" "./%n" "%n") (f77 (name . "\\.[Ff]$") "f77 %f -o %n" "./%n" "%n") (php (or (name . "\\.php$") (mode . php-mode)) "php %f" "php %f") (elisp (or (name . "\\.el$") (mode . emacs-lisp-mode) (mode . lisp-interaction-mode)) (emacs-lisp-byte-compile) (emacs-lisp-byte-compile) "%fc")) "\
Settings for certain file type.
A list like ((TYPE CONDITION COMPILE-COMMAND RUN-COMMAND EXE-FILE) ...).
In commands, these format specification are available:

  %i  interpreter name
  %F  absolute pathname            ( /usr/local/bin/netscape.bin )
  %f  file name without directory  ( netscape.bin )
  %n  file name without extention  ( netscape )
  %e  extention of file name       ( bin )

The interpreter is the program in the shebang line. If the
program is valid(test with `executable-find'), then use this program,
otherwise, use interpreter in `interpreter-mode-alist' according
to the major mode.")

(custom-autoload 'compile-dwim-alist "compile-dwim" t)

(autoload 'compile-dwim-compile "compile-dwim" "\


\(fn FORCE &optional SENTINEL)" t nil)

(autoload 'compile-dwim-run "compile-dwim" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "compile-dwim" '("compile-dwim-" "vterm-compile")))

;;;***

;;;### (autoloads nil "lazy-buffer" "../lazy/lazy-buffer.el" (24656
;;;;;;  39456 515420 841000))
;;; Generated autoloads from ../lazy/lazy-buffer.el

(defvar vmacs-consult--source-git `(:name "GitFile" :narrow 103 :category file :face consult-file :history file-name-history :action ,#'consult--file-action :items ,(lambda nil (require 'lazy-buffer) (append (vmacs--git-files 0 "~/repos/vmacs") (vmacs--git-files 0 "~/repos/dotfiles") (vmacs--git-files 1 nil)))) "\
Recent file candidate source for `consult-buffer'.")

(defvar vmacs-consult--source-dired `(:name "Dired" :narrow 100 :category file :face consult-file :history vmacs-dired-history :action ,#'consult--file-action :items ,(lambda nil (require 'vmacs-dired-history) vmacs-dired-history)) "\
Recent dired candidate source for `consult-buffer'.")

(autoload 'vmacs-prev-buffer "lazy-buffer" nil t nil)

(autoload 'vmacs-next-buffer "lazy-buffer" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lazy-buffer" '("boring-window-modes" "git-repos-files-cache" "vmacs--git-files")))

;;;***

;;;### (autoloads nil "lazy-camelize" "../lazy/lazy-camelize.el"
;;;;;;  (24656 39456 516033 282000))
;;; Generated autoloads from ../lazy/lazy-camelize.el

(autoload 'toggle-camelize "lazy-camelize" "\
hello_word <->HelloWorld" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lazy-camelize" '("camelize" "mapcar-head" "s-lowercase" "un-camelcase-string" "upcase-first-char")))

;;;***

;;;### (autoloads nil "lazy-command" "../lazy/lazy-command.el" (24656
;;;;;;  39456 516621 334000))
;;; Generated autoloads from ../lazy/lazy-command.el

(autoload 'vmacs-idle-timer "lazy-command" nil nil nil)

(autoload 'open-line-or-new-line-dep-pos "lazy-command" "\
binding this to `C-j' if point is at head of line then
open-line if point is at end of line , new-line-and-indent" t nil)

(autoload 'smart-beginning-of-line "lazy-command" "\
Move point to first non-whitespace character or beginning-of-line.
Move point to beginning-of-line ,if point was already at that position,
  move point to first non-whitespace character. " t nil)

(autoload 'org-mode-smart-beginning-of-line "lazy-command" "\
Move point to first non-whitespace character or beginning-of-line.
Move point to beginning-of-line ,if point was already at that position,
  move point to first non-whitespace character. " t nil)

(autoload 'smart-end-of-line "lazy-command" "\
like `org-end-of-line' move point to
   virtual end of line
or Move point to end of line (ignore white space)
or end-of-line.
Move point to end-of-line ,if point was already at end of line (ignore white space)
  move point to end of line .if `C-u', then move to end of line directly.

\(fn &optional ARG)" t nil)

(autoload 'org-mode-smart-end-of-line "lazy-command" "\
Move point to first non-whitespace character or end-of-line.
Move point to end-of-line ,if point was already at that position,
  move point to first non-whitespace character." t nil)

(autoload 'switch-to-scratch-buffer "lazy-command" "\
Toggle between *scratch* buffer and the current buffer.
     If the *scratch* buffer does not exist, create it." t nil)

(autoload 'sdcv-to-buffer "lazy-command" "\
Search dict in region or world." t nil)

(autoload 'just-one-space-or-delete-horizontal-space "lazy-command" "\
just one space or delete all horizontal space." t nil)

(autoload 'vmacs-kill-region-or-line "lazy-command" "\
this function is a wrapper of (kill-line).
   When called interactively with no active region, this function
  will call (kill-line) ,else kill the region.

\(fn &optional ARG)" t nil)

(autoload 'vmacs-kill-region-or-org-kill-line "lazy-command" "\
this function is a wrapper of (kill-line).
   When called interactively with no active region, this function
  will call (kill-line) ,else kill the region.

\(fn &optional ARG)" t nil)

(autoload 'vmacs-kill-buffer-dwim "lazy-command" "\


\(fn &optional BUF)" t nil)

(autoload 'vmacs-undo-kill-buffer "lazy-command" "\
Reopen the most recently killed file, if one exists." t nil)

(autoload 'kill-other-buffers "lazy-command" "\
kill all buffer which not showing in window." t nil)

(autoload 'bury-buffer-and-window "lazy-command" "\
bury buffer and window" t nil)

(autoload 'vmacs-append-semicolon-at-eol "lazy-command" "\


\(fn &optional ARG)" t nil)

(autoload 'vmacs-comment-dwim-line "lazy-command" "\
Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line.

\(fn &optional ARG)" t nil)

(autoload 'ibuffer-ediff-merge "lazy-command" "\


\(fn &optional ARG)" t nil)

(autoload 'minibuffer-quit "lazy-command" "\
Quit the minibuffer command, even when the minibuffer loses focus." t nil)

(autoload 'minibuffer-refocus "lazy-command" "\
Refocus the minibuffer if it is waiting for input." t nil)

(autoload 'dos2unix "lazy-command" nil t nil)

(autoload 'unix2dos "lazy-command" nil t nil)

(autoload 'cd-iterm2 "lazy-command" nil t nil)

(autoload 'cd-iterm2-new-tab "lazy-command" nil t nil)

(autoload 'toggle-case-fold "lazy-command" nil t nil)

(autoload 'consult-hide-lines "lazy-command" nil t nil)

(autoload 'consult-reset-lines "lazy-command" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lazy-command" '("vmacs-killed-file-list")))

;;;***

;;;### (autoloads nil "lazy-dired" "../lazy/lazy-dired.el" (24656
;;;;;;  39456 517765 617000))
;;; Generated autoloads from ../lazy/lazy-dired.el

(autoload 'dired-add-to-load-path-or-load-it "lazy-dired" "\
on `dired-mode',if thing under point is directory add it to `load-path'
if it is a el-file ,then `load' it" t nil)

;;;***

;;;### (autoloads nil "lazy-dired-sort" "../lazy/lazy-dired-sort.el"
;;;;;;  (24656 39456 517218 271000))
;;; Generated autoloads from ../lazy/lazy-dired-sort.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lazy-dired-sort" '("lazy-dired-sort")))

;;;***

;;;### (autoloads nil "lazy-evil" "../lazy/lazy-evil.el" (24656 39456
;;;;;;  519484 271000))
;;; Generated autoloads from ../lazy/lazy-evil.el

(autoload 'evil-mark-defun "lazy-evil" "\
call function binding to `C-M-h'

\(fn &optional ARG)" t nil)

(autoload 'evil-M-h "lazy-evil" "\
call function binding to `M-h'

\(fn &optional ARG)" t nil)

(autoload 'evil-mark-whole-buffer "lazy-evil" "\
call function binding to `C-xh'

\(fn &optional ARG)" t nil)

(autoload 'evil-begin-of-defun "lazy-evil" "\
call function binding to `C-M-a'

\(fn &optional ARG)" t nil)

(autoload 'evil-end-of-defun "lazy-evil" "\
call function binding to `C-M-e'

\(fn &optional ARG)" t nil)

(autoload 'evil-M-e "lazy-evil" "\
call function binding to `M-e'

\(fn &optional ARG)" t nil)

(autoload 'evil-M-a "lazy-evil" "\
call function binding to `M-a'

\(fn &optional ARG)" t nil)

(autoload 'evil-C-M-f "lazy-evil" "\
call function binding to `C-M-f'

\(fn &optional ARG)" t nil)

(autoload 'evil-C-M-b "lazy-evil" "\
call function binding to `C-M-b'

\(fn &optional ARG)" t nil)

(autoload 'evil-C-M-k "lazy-evil" "\
call function binding to `C-M-k'

\(fn &optional ARG)" t nil)

(autoload 'evil-copy-sexp-at-point "lazy-evil" "\
call function binding to `C-M-kC-/'

\(fn &optional ARG)" t nil)

(autoload 'evil-repeat-find-char-or-evil-use-register "lazy-evil" "\
default evil `f' find char ,and `;' repeat it ,now I bound `to' this cmd
so that if you call `f' first, then `;' will repeat it ,
if not,it will call `evil-use-register' which default bind on `\"' 

\(fn &optional REGISTER-OR-COUNT)" t nil)

(autoload 'vmacs-smart-double-ctrl-c "lazy-evil" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lazy-evil" '("evil-mark-funs-marker")))

;;;***

;;;### (autoloads nil "lazy-evil-symbol" "../lazy/lazy-evil-symbol.el"
;;;;;;  (24656 39456 518976 927000))
;;; Generated autoloads from ../lazy/lazy-evil-symbol.el
 (autoload 'evil-forward-symbol-begin "lazy-evil-symbol" nil t)
 (autoload 'evil-backward-symbol-begin "lazy-evil-symbol" nil t)
 (autoload 'evil-forward-symbol-end "lazy-evil-symbol" nil t)
 (autoload 'evil-forward-symbol-end "lazy-evil-symbol" nil t)

;;;***

;;;### (autoloads nil "lazy-golang" "../lazy/lazy-golang.el" (24656
;;;;;;  39456 520195 771000))
;;; Generated autoloads from ../lazy/lazy-golang.el

(autoload 'golang-setter-getter "lazy-golang" "\
generate sets and gets for golang.

\(fn BEG END)" t nil)

;;;***

;;;### (autoloads nil "lazy-json" "../lazy/lazy-json.el" (24656 39456
;;;;;;  520850 907000))
;;; Generated autoloads from ../lazy/lazy-json.el

(autoload 'vmacs-json-pretty "lazy-json" nil t nil)

;;;***

;;;### (autoloads nil "lazy-magit" "../lazy/lazy-magit.el" (24656
;;;;;;  39456 521213 766000))
;;; Generated autoloads from ../lazy/lazy-magit.el

(autoload 'toggle-diff-whitespace "lazy-magit" nil t nil)

(autoload 'vmacs-magit-blob-save "lazy-magit" nil t nil)

(autoload 'vmacs-magit-blob-quit "lazy-magit" nil t nil)

(autoload 'vmacs-magit-blob-toggle "lazy-magit" nil t nil)

;;;***

;;;### (autoloads nil "lazy-novel-mode" "../lazy/lazy-novel-mode.el"
;;;;;;  (24656 39456 521929 68000))
;;; Generated autoloads from ../lazy/lazy-novel-mode.el

(autoload 'novel-fill "lazy-novel-mode" nil t nil)

(autoload 'chinese-normal "lazy-novel-mode" nil t nil)

;;;***

;;;### (autoloads nil "lazy-open-in-file-manager" "../lazy/lazy-open-in-file-manager.el"
;;;;;;  (24656 39456 522279 79000))
;;; Generated autoloads from ../lazy/lazy-open-in-file-manager.el

(autoload 'open-in-filemanager "lazy-open-in-file-manager" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lazy-open-in-file-manager" '("reveal-in-osx-finder" "w32explore")))

;;;***

;;;### (autoloads nil "lazy-org" "../lazy/lazy-org.el" (24656 39456
;;;;;;  522805 424000))
;;; Generated autoloads from ../lazy/lazy-org.el

(autoload 'vmacs-org-insert-image "lazy-org" "\


\(fn EVENT)" t nil)

(autoload 'show-todo-list-after-init "lazy-org" "\


\(fn &optional FRAME)" nil nil)

;;;***

;;;### (autoloads nil "lazy-program-objc" "../lazy/lazy-program-objc.el"
;;;;;;  (24656 39456 523414 275000))
;;; Generated autoloads from ../lazy/lazy-program-objc.el

(autoload 'objc-surround "lazy-program-objc" nil t nil)

;;;***

;;;### (autoloads nil "lazy-program-protobuf" "../lazy/lazy-program-protobuf.el"
;;;;;;  (24656 39456 523929 846000))
;;; Generated autoloads from ../lazy/lazy-program-protobuf.el

(autoload 'protobuf-indent-align "lazy-program-protobuf" "\
do indent and align for protobuf.
bind`indent-region-function' to this function in protobuf-hook

\(fn BEGIN END &optional COLUMN)" t nil)

;;;***

;;;### (autoloads nil "lazy-smart-tab" "../lazy/lazy-smart-tab.el"
;;;;;;  (24656 39456 524702 296000))
;;; Generated autoloads from ../lazy/lazy-smart-tab.el

(autoload 'smart-tab "lazy-smart-tab" "\


\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lazy-smart-tab" '("smart-tab-")))

;;;***

;;;### (autoloads nil "lazy-sudo" "../lazy/lazy-sudo.el" (24656 39456
;;;;;;  525169 53000))
;;; Generated autoloads from ../lazy/lazy-sudo.el

(autoload 'toggle-read-only-file-with-sudo "lazy-sudo" "\


\(fn &optional ARGV)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lazy-sudo" '("toggle-with-sudo-history-host-user-alist")))

;;;***

;;;### (autoloads nil "lazy-version-control" "../lazy/lazy-version-control.el"
;;;;;;  (24656 39456 526225 518000))
;;; Generated autoloads from ../lazy/lazy-version-control.el

(autoload 'log-view-ediff "lazy-version-control" "\
the ediff version of `log-view-diff'

\(fn BEG END)" t nil)

(autoload 'vc-command "lazy-version-control" "\
run vc command" t nil)

(autoload 'vmacs-magit-push-default "lazy-version-control" "\


\(fn &optional ARGS UPSTREAM)" t nil)

(autoload 'vmacs-magit-pull-default "lazy-version-control" "\


\(fn &optional ARGS UPSTREAM)" t nil)

(autoload 'vmacs-vc-next-action "lazy-version-control" nil t nil)

;;;***

;;;### (autoloads nil "lazy-window" "../lazy/lazy-window.el" (24656
;;;;;;  39456 526632 859000))
;;; Generated autoloads from ../lazy/lazy-window.el

(autoload 'vmacs-split-window-horizontally "lazy-window" nil t nil)

(autoload 'vmacs-split-window-vertically "lazy-window" nil t nil)

(autoload 'toggle-split-window "lazy-window" nil t nil)

(autoload 'gui-frame-cnt "lazy-window" nil nil nil)

(autoload 'vmacs-split-window-or-other-window "lazy-window" nil t nil)

(autoload 'vmacs-split-window-or-prev-window "lazy-window" nil t nil)

(autoload 'vmacs-window-rotate "lazy-window" "\
Rotates the windows according to the currenty cyclic ordering." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lazy-window" '("split-window-status")))

;;;***

;;;### (autoloads nil "mysql-query" "../lazy/mysql-query.el" (24656
;;;;;;  39456 527700 780000))
;;; Generated autoloads from ../lazy/mysql-query.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mysql-query" '("mysql-")))

;;;***

;;;### (autoloads nil "sqlparser-mysql-complete" "../lazy/sqlparser-mysql-complete.el"
;;;;;;  (24656 39456 528773 496000))
;;; Generated autoloads from ../lazy/sqlparser-mysql-complete.el

(autoload 'mysql-complete-minor-mode "sqlparser-mysql-complete" "\
mode for editing mysql script

If called interactively, enable Mysql-Complete minor mode if ARG
is positive, and disable it if ARG is zero or negative.  If
called from Lisp, also enable the mode if ARG is omitted or nil,
and toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'sqlparser-mysql-complete "sqlparser-mysql-complete" "\
complete tablename or column name depending on current point position .
when you first call this command ,it will ask you for the sql-database ,user ,password
host and port. the info will be stored in `mysql-connection-4-complete'. it can be
reused . with `C-u' you can change the dbname.
with `C-uC-u' you can use another new mysql connection

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sqlparser-mysql-complete" '("mysql-co" "sqlparser-")))

;;;***

;;;### (autoloads nil "vmacs-dired-history" "../lazy/vmacs-dired-history.el"
;;;;;;  (24656 39456 529473 273000))
;;; Generated autoloads from ../lazy/vmacs-dired-history.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "vmacs-dired-history" '("vmacs-dired-history")))

;;;***

;;;### (autoloads nil "vmacs-dired-single" "../lazy/vmacs-dired-single.el"
;;;;;;  (24656 39456 530331 462000))
;;; Generated autoloads from ../lazy/vmacs-dired-single.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "vmacs-dired-single" '("dired-mouse-find-alternate-file" "vmacs-dired-single-kill-other-dired")))

;;;***

(provide 'lazy-loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; lazy-loaddefs.el ends here