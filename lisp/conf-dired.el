;;q        quit
;; f <RET> open file 打开文件
;; o       open file other window 在另一个窗口中打开文件
;;C-o      open file other window (point in this window) ,在另个窗口打开文件,焦点仍在当前window
;;v        view-file 只读打开(q 退出)
;; ^       上层目录 ,我改成了u,以方便操作

;;关于mark,将文件标记之后,一些处理文件的命令会对mark的所有文件
;;采取一致的行动,如删除等.

;; m与*m 标记为"*"
;; **    标记所有可执行文件
;; *@    标记所有软连接文件
;; */    标记所有目录(.与..除外)
;; *s    标记当前目录的所有
;; u与*u     删除标记 (u被我重定义为回到上层)
;; U与*!  删除所有标记
;; %d REGEXP  将所有文件匹配的文件标记为D(删除)
;; %m REGEXP  将所有文件匹配的文件标记为*
;; %g REGEXP <RET>  如果文件中的内容匹配正则表达示则标记之
;; *C-n 移动到下一个标记的文件
;; *C-p .....上...........
;;

;;操作文件的命令,有以下规则
;;如果有前缀参数N 则对从当前文件开始的N个文件执行操作,负数则反向
;;否则对标记mark为*的文件,
;;否则 当前文件

;;C  copy
;; (setq dired-copy-preserve-time t),copy时保留原文件的修改时间 如果cp -p

;;D  delete  ,经确认后马上删除
;;d  detele 实际只是标记此文件为删除,执行x 才真正删除

;;R   mv rename 重命名,移动文件
;;H  硬链接
;;M  chmod  ,如M 755 修改为755
;;G  change group
;;O   change owner
;;T  touch file
;;Z   compress or uncompress
;;L   load lisp
;;A REGEXP  ,在文件中search   ,M-, 跳到下一个
;;Q REGEXP  ,query-replace-regexp(`dired-do-query-replace-regexp').

;;子目录
;;i 同时打开目录
;;$ hide or show 当前目录
;;指定隐藏哪些文件 : C-o, toggle


;; g refresh all
;; l  refresh mark的文件
;; k 隐藏指定文件
;; s 排序 字母,或date 间toggle


;;编辑,输入C-x C-q 切换到writable 模式,此时修改文件名,然后C-c c-c 提交
;;也或以移动文件,将文件名写成相应的路径名即可
;;设置在writable 模式下允许修改权限
;;(setq wdired-allow-to-change-permissions t)
;;C-td 会将目录中所有标记的文件生成缩略图,图片预览

;;w  copy the file name
;;C-u0w copy 全路径名

;;dired 支持拖放,你可以在pcmanfm nautils 中将文件,拖动到dired buffer 中

;;正则表达式的应用
;;% R FROM <RET> TO <RET>'   ;rename
;;% C FROM <RET> TO <RET>'   ; copy
;;% H FROM <RET> TO <RET>'   ; Hard link
;;% S FROM <RET> TO <RET>'   ; soft link
;;FROM TO 是一个正则,另外在TO 中可以用\&引用FROM整个的匹配组,\数字匹配某一个组
;;如 % R ^.*$ <RET> \&.tmp <RET>' 重命名所有标记的文件为*.tmp

;;= diff
;;M-=  diff 与backup

;;!与X 执行shell 命令,"*" 代表选中的文件名
;;如我想把abc 文件移动到/tmp
;; !cp * /tmp
;; !tar -cf a.tar *
;; !for file in * ; do mv "$file" "$file".tmp; done
;;
;;与*类似但不相同的"?" 表示对mark的文件"分别" 运行这个命令
;;; image-dired

(require 'savehist)
(add-to-list 'savehist-additional-variables 'ivy-dired-history-variable)
(savehist-mode 1)


(require 'ivy-dired-history)


(define-key dired-mode-map "," 'dired)  ;;


(define-key dired-mode-map "u" 'dired-up-directory) ;上层目录

(define-key dired-mode-map  "/" 'dired-narrow) ;dired-narrow-fuzzy
(define-key dired-mode-map  (kbd "C-s") 'dired-narrow) ;dired-narrow-fuzzyxs


;; (require 'dired-single)
;; // 单个buffer
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq dired-dwim-target t)

;; (put 'dired-find-alternate-file 'disabled nil)
;; (with-eval-after-load 'dired
;;     (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
;;     (define-key dired-mode-map (kbd "u") (lambda () (interactive) (find-alternate-file ".."))))  ; was dired-up-directory)


;; (require 'ls-lisp)
;; (setq ls-lisp-use-insert-directory-program nil)
;; (setq ls-lisp-verbosity nil)


;; dired 目录排序			       
(defun custom-dired-sort-dir-first ()
  "Dired sort hook to list directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
  (and (featurep 'xemacs)
       (fboundp 'dired-insert-set-properties)
       (dired-insert-set-properties (point-min) (point-max)))
  (set-buffer-modified-p nil)
  )
(add-hook 'dired-after-readin-hook 'custom-dired-sort-dir-first)

(use-package dired-subtree
  :defer t
  :bind (:map dired-mode-map
              ("TAB" . dired-subtree-cycle)))


;; Make dired less verbose
;; (add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode 1)))

;; (add-ho;; ok 'dired-mode-hook (lambda () (diredfl-mode 1)))
;; (after-load 'dired
;;     (diredfl-global-mode)
;;     (require 'dired-x))
;; Move files between split panes
;; (setq dired-dwim-target t)

(set-face-foreground 'dired-directory "green")

(require 'dired-filetype-face)

 (after-load 'dired
   (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(define-key dired-mode-map "i" 'wdired-change-to-wdired-mode)

(provide 'conf-dired)
