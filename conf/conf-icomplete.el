;; -*- lexical-binding: t -*-
;;; Code:

;;; ============================================================
;;; 第一部分：基础依赖加载
;;; ============================================================
(require 'icomplete)   ;; Emacs 内置的增量补全框架，在 minibuffer 中实时显示候选项
(require 'recentf)     ;; 记录最近打开的文件，方便快速访问
(require 'consult)     ;; 现代化的搜索和导航框架，提供 buffer 切换、文件搜索、ripgrep 等功能

;;; ============================================================
;;; 第二部分：Minibuffer 基础配置
;;; ============================================================
;; 【递归 minibuffer】允许在 minibuffer 中再次调用需要 minibuffer 的命令
;; 例如：在 M-x 输入命令时，可以再按 C-h f 查看函数帮助
(setq enable-recursive-minibuffers t)

;; 【历史去重】minibuffer 历史记录中删除重复项
(setq history-delete-duplicates t)

;; 【Prompt 保护】minibuffer 的提示文字只读，光标无法进入
;; 防止误删 "Find file: " 这样的提示
(setq minibuffer-prompt-properties
      '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))

;;; ============================================================
;;; 第三部分：补全行为配置
;;; ============================================================
;; 【循环补全阈值】当候选项 ≤3 个时，TAB 可以循环切换候选项
;; 例如：只有 3 个匹配时，连续按 TAB 会在它们之间循环
(setq completion-cycle-threshold 3)

;; 【部分补全分隔符】partial-completion 风格时，自动插入分隔符
;; 例如：输入 "f-b" 可以匹配 "foo-bar"
(setq completion-pcm-complete-word-inserts-delimiters t)

;; 【自动帮助】设为 t 表示自动显示 *Completions* 窗口（这里实际是启用）
(setq completion-auto-help t)

;;; ============================================================
;;; 第四部分：*Completions* 窗口配置（旧式补全弹窗）
;;; ============================================================
;; 【单列显示】*Completions* 窗口中候选项单列显示，更易阅读
(setq completions-format 'one-column)

;; 【隐藏头部】不显示 "Possible completions are:" 这样的头部文字
(setq completions-header-format nil)

;; 【高度限制】minibuffer 最大高度为 10 行
(setq max-mini-window-height 10)

;; 【补全窗口高度】*Completions* 窗口最大高度
(setq completions-max-height 10)

;; 【icomplete 候选数】icomplete 显示的候选项数量
(setq icomplete-prospects-height 10)

;; 【详细信息】显示补全项的详细信息（如函数签名）
(setq completions-detailed t)

;; 【隐藏帮助】不在 *Completions* 窗口显示帮助信息
(setq completion-show-help nil)

;; 【Eldoc 多行】eldoc 在 echo area 最多显示 2 行
(setq eldoc-echo-area-use-multiline-p 2)

;; 【窗口只增不减】minibuffer 窗口只会变大，不会自动缩小（避免闪烁）
(setq resize-mini-windows 'grow-only)

;; 【缩短默认值】当有默认值时，显示简短形式
(setq minibuffer-eldef-shorten-default t)

;; 【电动默认模式】输入内容后自动隐藏 prompt 中的默认值
;; 例如：输入字符后 "[default foo]" 会消失
(minibuffer-electric-default-mode 1)

;; 【文件名阴影】输入新路径时，旧路径变灰
;; 例如：输入 /etc/ 后再输入 ~/，前面的 /etc/ 会变灰
(file-name-shadow-mode 1)

;; 【深度指示】显示 minibuffer 嵌套深度，如 [2] 表示第 2 层
(minibuffer-depth-indicate-mode 1)

;; 【*Completions* 快捷键】在 *Completions* 窗口中 C-g 关闭窗口
(define-key completion-list-mode-map (kbd "C-g") 'quit-window)

;;; ============================================================
;;; 第五部分：Minibuffer 快捷键配置
;;; ============================================================
(defun vmacs-minibuffer-hook()
  "Minibuffer 启动时的钩子函数，设置局部快捷键"
  ;; C-. 触发补全（在 minibuffer 中也能用代码补全）
  (local-set-key (kbd "C-.") 'completion-at-point)
  ;; C-m (回车) 确认并退出 minibuffer
  (local-set-key (kbd "<C-m>") 'exit-minibuffer)
  ;; C-h 向后删除一个字符（类似 Backspace）
  (local-set-key (kbd "<C-h>") 'backward-delete-char-untabify)
  ;; C-l 向后删除一个单词
  (local-set-key (kbd "C-l") 'backward-kill-word)
  ;; ESC 取消并退出 minibuffer
  (local-set-key [escape] 'abort-recursive-edit)
  ;; TAB 触发补全
  (local-set-key (kbd "TAB") 'minibuffer-complete)
  (local-set-key (kbd "<tab>") 'minibuffer-complete)
  ;; F19 忽略（用于 isearch 兼容）
  (local-set-key  (kbd "<f19>") #'ignore)
  ;; M-p / M-n 浏览历史记录
  (define-key minibuffer-local-map (kbd "M-p") 'previous-history-element)
  (define-key minibuffer-local-map (kbd "M-n") 'next-history-element)
  )

(add-hook 'minibuffer-setup-hook #'vmacs-minibuffer-hook)

;;; ============================================================
;;; 第六部分：icomplete 配置
;;; ============================================================
;; 【延迟阈值】候选项超过 2000 个时才延迟计算（提高性能）
(setq icomplete-delay-completions-threshold 2000)

;; 【计算延迟】补全计算无延迟，立即响应
(setq icomplete-compute-delay 0)

;; 【空输入显示】即使没有输入也显示候选项
;; 例如：M-x 后立即显示所有命令
(setq icomplete-show-matches-on-no-input t)

;; 【保留公共前缀】不隐藏候选项的公共前缀
(setq icomplete-hide-common-prefix nil)

;; 【Buffer 内 icomplete】在 buffer 内补全时也使用 icomplete
;; 注意：如果用 corfu，这个设置会被覆盖
(setq icomplete-in-buffer t)
(setq icomplete-vertical-in-buffer-adjust-list t)

;; 【隐藏 *Completions*】补全后自动隐藏旧式 *Completions* 窗口
;; 防止与 corfu/icomplete 的现代 UI 冲突
(advice-add 'completion-at-point :after #'minibuffer-hide-completions)

;;; ============================================================
;;; 第七部分：Buffer 内补全配置
;;; ============================================================
;; 【TAB 行为】TAB 键：如果已缩进则触发补全，否则缩进
;; 'complete 表示：先尝试缩进，已缩进则补全
(setq tab-always-indent 'complete)

;; 【补全 UI】使用 consult 的补全 UI 替代默认的 *Completions* 窗口
;; 这会让 buffer 内补全显示在 minibuffer 中，类似 icomplete 风格
(setq completion-in-region-function #'consult-completion-in-region)

;; 【补全预览】启用全局补全预览模式
;; 输入时会在光标后显示灰色的补全建议（类似 GitHub Copilot）
(global-completion-preview-mode)

;; 【忽略大小写】补全时忽略大小写
(setq completion-preview-ignore-case t)
(setq completion-ignore-case t)

;; 【隐藏不适用命令】M-x 中隐藏当前 mode 不适用的命令
;; 例如：在非 org-mode buffer 中不显示 org-* 命令
(setq read-extended-command-predicate #'command-completion-default-include-p)

;; 【补全后端】添加额外的补全来源
;; cape-file: 文件路径补全（输入 ~/ 或 ./ 时触发）
;; cape-dabbrev: 从当前 buffer 和其他 buffer 中提取单词补全
(add-to-list 'completion-at-point-functions #'cape-file)
(add-to-list 'completion-at-point-functions #'cape-dabbrev)

(defun vmacs-complete()
  "隐藏补全预览并执行缩进"
  (interactive)
  (completion-preview-hide)
  (indent-for-tab-command))

;;; ============================================================
;;; 第八部分：补全预览快捷键
;;; ============================================================
;; 当补全预览显示时（光标后的灰色文字），以下快捷键生效：
;; C-n / C-i: 隐藏预览并缩进

(when (require 'completion-preview nil t)(global-completion-preview-mode))
(with-eval-after-load 'completion-preview
  (define-key completion-preview-active-mode-map (kbd "C-n") #'vmacs-complete)
  (define-key completion-preview-active-mode-map (kbd "C-i") #'vmacs-complete)
  ;; C-o: 展开更多补全选项
  (define-key completion-preview-active-mode-map (kbd "C-o") #'completion-preview-complete)
  ;; C-j: 插入当前预览的补全
  (define-key completion-preview-active-mode-map (kbd "C-j") #'completion-preview-insert)
  ;; C-s: 切换到下一个候选项
  (define-key completion-preview-active-mode-map (kbd "C-s") #'completion-preview-next-candidate)
  ;; M-f: 只插入预览的一个单词
  (define-key completion-preview-active-mode-map (kbd "M-f") #'completion-preview-insert-word)

  ;; 【最小长度】nil 表示任意长度都显示预览
  (setq completion-preview-minimum-symbol-length nil)
  (setq completion-preview-idle-delay 0.001)
)


;;; ============================================================
;;; 第九部分：补全风格配置
;;; ============================================================
;; 【预览补全风格】补全预览使用的匹配算法
(setq completion-preview-completion-styles '(basic partial-completion initials orderless))

;; 【文件名阴影】输入新路径时自动清理被遮蔽的旧路径
(setq icomplete-tidy-shadowed-file-names t)

;; 【候选项分隔符】icomplete 水平显示时，候选项之间的分隔符
;; 显示为绿色的 " 👈 "
(setq icomplete-separator (propertize " 👈 " 'face  '(foreground-color . "lightgreen")))


;;; ============================================================
;;; 第十部分：补全风格（Completion Styles）
;;; ============================================================
;; 【默认补全风格】按顺序尝试以下匹配算法：
;; - basic: 精确前缀匹配（输入 "foo" 匹配 "foobar"）
;; - partial-completion: 部分匹配（输入 "f-b" 匹配 "foo-bar"）
;; - substring: 子串匹配（输入 "bar" 匹配 "foobar"）
;; - initials: 首字母匹配（输入 "fb" 匹配 "foo-bar"）
;; - flex: 模糊匹配（输入 "fb" 匹配 "foobar"，字符可以不连续）
(setq completion-styles '(basic partial-completion substring initials  flex))

;;; ============================================================
;;; 第十一部分：Orderless 配置（高级模糊匹配）
;;; ============================================================
;; Orderless 是一个强大的补全风格，支持空格分隔的多关键字匹配
;; 例如：输入 "buf swi" 可以匹配 "switch-to-buffer"
(when (require 'orderless nil t)
  ;; 启用 orderless 后的补全风格
  (setq completion-styles '(basic partial-completion initials orderless))

  ;; 【拼音支持】支持用拼音首字母搜索中文
  ;; 例如：输入 "wj" 可以匹配 "文件"
  (defun completion--regex-pinyin (str)
    (require 'pinyinlib)
    (orderless-regexp (pinyinlib-build-regexp-string str)))

  ;; 【匹配算法】每个空格分隔的关键字支持以下匹配方式：
  ;; - completion--regex-pinyin: 拼音首字母
  ;; - orderless-regexp: 正则表达式
  ;; - orderless-literal: 字面匹配
  ;; - orderless-initialism: 首字母匹配
  (setq orderless-matching-styles '(completion--regex-pinyin orderless-regexp
                                                            orderless-literal orderless-initialism))

  ;; 【自定义风格】定义一个优先首字母匹配的风格
  (orderless-define-completion-style +orderless-with-initialism
    (orderless-matching-styles '(orderless-initialism orderless-literal orderless-regexp )))

  ;; 【分类覆盖】为不同类型的补全指定不同的匹配风格
  (setq completion-category-overrides
        '((eglot (styles orderless))                              ;; LSP 补全用 orderless
          (multi-category (styles . (basic partial-completion orderless)))
          (file (styles partial-completion))                      ;; 文件路径用 partial-completion
          (command (styles +orderless-with-initialism))           ;; M-x 命令优先首字母
          (variable (styles +orderless-with-initialism))          ;; 变量名优先首字母
          (symbol (styles +orderless-with-initialism))))          ;; 符号名优先首字母

  ;; 【转义空格】允许用 \ 转义空格，输入字面空格
  (setq orderless-component-separator #'orderless-escapable-split-on-space)

  ;; 【$ 后缀修复】修复 consult-buffer 中 $ 结尾匹配的问题
  ;; 例如：输入 "el$" 匹配以 "el" 结尾的 buffer
  (defun +orderless-fix-dollar (word &optional _index _total)
    (let ((consult-suffix
           (if (and (boundp 'consult--tofu-char) (boundp 'consult--tofu-range))
               (format "[%c-%c]*$"
                       consult--tofu-char
                       (+ consult--tofu-char consult--tofu-range -1))
             "$")))
      (concat word consult-suffix)))

  ;; 【特殊前缀/后缀】输入特定字符触发不同匹配方式：
  ;; $ 结尾匹配    例如：foo$ 匹配以 foo 结尾
  ;; % 字符折叠    例如：cafe% 匹配 café
  ;; ! 否定匹配    例如：!foo 排除包含 foo 的
  ;; & 注解匹配    匹配 marginalia 显示的注解
  ;; , 模糊匹配    例如：fb, 模糊匹配 foobar
  ;; = 字面匹配    例如：foo= 精确匹配 foo
  ;; ^ 前缀匹配    例如：^foo 匹配以 foo 开头
  ;; ~ 首字母匹配  例如：fb~ 首字母匹配 foo-bar
  (setq orderless-affix-dispatch-alist
        `((?$ . +orderless-fix-dollar)
          (?% . ,#'char-fold-to-regexp)
          (?! . ,#'orderless-not)
          (?& . ,#'orderless-annotation)
          (?, . ,#'orderless-flex)
          (?= . ,#'orderless-literal)
          (?^ . ,#'orderless-literal-prefix)
          (?~ . ,#'orderless-initialism))))

;;; ============================================================
;;; 第十二部分：启用 icomplete
;;; ============================================================
;; 启用 icomplete 模式（在 minibuffer 中显示候选项）
(icomplete-mode 1)

;; 启用垂直显示模式（候选项垂直排列，更易阅读）
(icomplete-vertical-mode 1)

;; 【滚动】启用候选列表滚动（超出显示范围时可以滚动查看）
(setq icomplete-scroll t)


;;; ============================================================
;;; 第十三部分：icomplete 快捷键配置
;;; ============================================================
;; 在 icomplete minibuffer 中的快捷键：
;; RET / C-m: 确认选择（fido 风格，更智能）
(define-key icomplete-minibuffer-map (kbd "RET") 'icomplete-fido-ret)
(define-key icomplete-minibuffer-map (kbd "C-m") 'icomplete-fido-ret)
;; C-n / C-p: 上下选择候选项
(define-key icomplete-minibuffer-map (kbd "C-n") #'icomplete-forward-completions)
(define-key icomplete-minibuffer-map (kbd "C-p") #'icomplete-backward-completions)
;; C-s / C-r: 同上（类似 isearch 风格）
(define-key icomplete-minibuffer-map (kbd "C-s") #'icomplete-forward-completions)
(define-key icomplete-minibuffer-map (kbd "C-r") #'icomplete-backward-completions)
;; M-.: 下一条历史记录
(define-key icomplete-minibuffer-map (kbd "M-.") 'next-history-element)
;; C-l: 返回上级目录（在文件选择时）
(define-key icomplete-minibuffer-map (kbd "C-l") #'icomplete-fido-backward-updir)
;; C-e: 行尾则确认退出，否则移动到行尾
(define-key icomplete-minibuffer-map (kbd "C-e") #'(lambda(&optional argv)(interactive)(if (eolp) (call-interactively #'icomplete-fido-exit) (end-of-line))) )
;; C-h: 插入 " -- -uuu"（用于 consult-ripgrep 忽略 .gitignore）
(define-key icomplete-minibuffer-map (kbd "C-h") #'(lambda()(interactive) (insert " -- -uuu")))

;;; ============================================================
;;; 第十四部分：Embark 和 Marginalia 配置
;;; ============================================================
;; Embark: 提供上下文操作菜单（类似右键菜单）
;; Marginalia: 在候选项旁边显示额外信息（如文件大小、函数签名）
(when (require 'embark nil t)
  (when (require 'marginalia nil t)
    ;; 启用 marginalia，显示候选项的额外信息
    (marginalia-mode 1)
    ;; 自定义文件注解：只显示完整路径
    (advice-add 'marginalia--annotate-local-file :override
                (defun marginalia--annotate-local-file-advice (cand)
                  (marginalia--fields
                   ((marginalia--full-candidate cand)
                    :face 'marginalia-size )))))

  ;; 【Embark 快捷键】
  ;; C-w: 触发 embark 操作菜单（全局和 minibuffer）
  (global-set-key  (kbd "C-w") 'embark-act)
  (define-key icomplete-minibuffer-map (kbd "C-w") 'embark-act)
  ;; C-c C-o: 收集当前候选项到新 buffer
  (define-key icomplete-minibuffer-map (kbd "C-c C-o") 'embark-collect-snapshot)
  ;; C-c C-c: 导出候选项（如导出到 grep buffer 进行编辑）
  (define-key icomplete-minibuffer-map (kbd "C-c C-c") 'embark-export)

  ;; Embark 收集 buffer 的钩子
  (defun vmacs-embark-collect-mode-hook ()
    ;; / 过滤显示的行
    (local-set-key "/" #'consult-focus-lines)
    ;; z 隐藏匹配的行
    (local-set-key  "z" #'consult-hide-lines))
  (add-hook 'tabulated-list-mode-hook 'vmacs-embark-collect-mode-hook))

;;; ============================================================
;;; 第十五部分：Consult 异步搜索配置
;;; ============================================================
;; 【异步分隔风格】使用 Perl 风格的分隔符
;; 输入 #pattern#filter 可以先搜索 pattern，再用 filter 过滤结果
(setq consult-async-split-style 'perl)

;; 【空格处理】智能处理空格和 # 的输入
(defun vmacs-minibuffer-space ()
  "智能空格：在特定情况下插入 # 而不是空格"
  (interactive)
  (if (and (string-prefix-p "#" (minibuffer-contents))
           (= 2 (length (split-string (minibuffer-contents) "#"))))
      (insert "#")
    (when (looking-back "#") (delete-char -1))
    (insert " ")))

(define-key icomplete-minibuffer-map (kbd "SPC") 'vmacs-minibuffer-space)

;;; ============================================================
;;; 第十六部分：Consult Buffer 和搜索配置
;;; ============================================================
;; 【项目根目录】使用 vc-root-dir 获取项目根目录
(setq consult-project-root-function #'vc-root-dir)

(with-eval-after-load 'consult
  (with-eval-after-load 'embark
    (require 'embark-consult nil t)
    ;; 【导出到 grep】将搜索结果导出到 grep buffer，可以用 wgrep 编辑
    (setf (alist-get 'xref-location embark-exporters-alist) #'vmacs-embark-consult-export-grep)
    (setf (alist-get 'consult-grep embark-exporters-alist) #'vmacs-embark-consult-export-grep)

    (defun vmacs-embark-consult-export-grep(lines)
      "导出搜索结果到 *grep* buffer"
      ;; 先关闭已有的 *grep* buffer
      (dolist (buf (buffer-list))
        (when (string-prefix-p "*grep" (buffer-name buf))
          (kill-buffer buf)))
      (let* ((default-directory default-directory)
             dir file)
        ;; 找到正确的工作目录
        (cl-find-if
         (lambda (line)
           (setq file (car (split-string line ":")))
           (unless (file-name-absolute-p file)
             (setq dir (locate-dominating-file default-directory file))
             (when dir (setq default-directory dir))))
         lines)
        (embark-consult-export-grep lines)
        (wgrep-change-to-wgrep-mode)
        )))

  ;; 导出后重命名 buffer 为 *grep*
  (add-hook 'embark-after-export-hook #'(lambda()(rename-buffer "*grep*" t)))

  ;; 【Buffer 来源】consult-buffer 显示的内容来源
  (setq consult-buffer-sources
        '(consult--source-buffer        ;; 当前打开的 buffer
          consult--source-recent-file   ;; 最近打开的文件
          vmacs-consult--source-git))   ;; Git 项目文件

  ;; 【自定义 recentf 显示】显示简短的文件名
  (defun vmacs-consult--source-recentf-items ()
    (let ((ht (consult--buffer-file-hash))
          file-name-handler-alist  ;; 禁用 Tramp，提高速度
          items)
      (dolist (file recentf-list (nreverse items))
        (unless (eq (aref file 0) ?/)
          (setq file (expand-file-name file)))
        (unless (gethash file ht)
          (push (propertize
                 (vmacs-short-filename file)
                 'multi-category `(file . ,file))
                items)))))

  (defun vmacs-short-filename(file)
    "返回简短文件名：文件名\\父目录名
例如：/a/b/c/d.el -> d.el\\c"
    (let* ((file (directory-file-name file))
           (filename (file-name-nondirectory file))
           (dir (file-name-directory file))
           (short-name filename))
      (when dir
        (setq short-name
              (format "%s\\%s" filename (file-name-nondirectory
                                         (directory-file-name dir)))))
      (propertize short-name 'multi-category `(file . ,file))))

  ;; 应用自定义的 recentf 显示
  (plist-put consult--source-recent-file
             :items #'vmacs-consult--source-recentf-items))


;;; ============================================================
;;; 第十七部分：Leader 键快捷键绑定
;;; ============================================================
;; 使用 vmacs-leader 宏定义 SPC 开头的快捷键
;; SPC fh: 在 home 目录打开文件
(vmacs-leader (kbd "fh") (vmacs-defun find-file-home (let ((default-directory "~/"))(call-interactively 'find-file))))
;; SPC ft: 在 /tmp 目录打开文件
(vmacs-leader (kbd "ft") (vmacs-defun find-file-tmp (let ((default-directory "/tmp/"))(call-interactively 'find-file))))
;; SPC fu: 打开 http 目录（Dropbox 中的 http 文件夹）
(vmacs-leader (kbd "fu") (vmacs-defun find-file-http (find-file (expand-file-name "http/" dropbox-dir))))
;; SPC fn: 打开笔记文件
(vmacs-leader (kbd "fn") (vmacs-defun find-file-note (require 'conf-org) (find-file org-default-notes-file)))


;; 【文件查找】
(setq ffap-machine-p-known 'accept)  ;; 禁用 ffap 的网络 ping 检测
;; SPC ff: 打开文件
(vmacs-leader (kbd "ff") #'find-file)
;; C-x C-f: 智能打开文件（会尝试识别光标下的路径）
(global-set-key (kbd "C-x C-f") #'find-file-at-point)
;; C-x r b: 书签跳转
(global-set-key (kbd "C-x r b") #'consult-bookmark)
;; C-x r x: 寄存器跳转
(global-set-key (kbd "C-x r x" ) #'consult-register)

;; SPC i: 打开 mu4e 邮件客户端
(vmacs-leader (kbd "i") (vmacs-defun vmacs-mu4e (call-process "killall" nil nil nil  "mbsync")(require 'mu4e)(mu4e t)(mu4e-search-bookmark)))

;; 【Buffer 和搜索】
;; SPC SPC: 切换 buffer（最常用！）
(vmacs-leader "<SPC>" 'consult-buffer)
;; SPC fo: 在其他窗口打开 buffer
(vmacs-leader "fo" 'consult-buffer-other-window)
;; SPC fl: 查找文件（使用 find 命令）
(vmacs-leader "fl" 'consult-find)
;; SPC gh: grep 搜索（使用 grep）
(vmacs-leader "gh" #'consult-grep)
;; SPC ge: 原生 grep
(vmacs-leader "ge" #'grep)
;; SPC gg: 在当前目录 ripgrep 搜索
(vmacs-leader "gg" (vmacs-defun consult-ripgrep-default (consult-ripgrep default-directory)))
;; SPC gt: 在项目根目录 ripgrep 搜索
(vmacs-leader "gt" #'consult-ripgrep)
;; SPC g.: 搜索光标下的符号（当前目录）
(vmacs-leader "g." (vmacs-defun consult-ripgrep-default-symbol (consult-ripgrep default-directory (concat "\\b" (thing-at-point 'symbol) "\\b"))))
;; SPC g,: 搜索光标下的符号（项目根目录）
(vmacs-leader "g," (vmacs-defun consult-ripgrep-root-symbol (consult-ripgrep(vc-root-dir)  (concat "\\b" (thing-at-point 'symbol) "\\b"))))

;; 【行号和 imenu】
;; M-g g: 跳转到指定行
(global-set-key [remap goto-line] 'consult-goto-line)
;; C-c C-s: 搜索当前 buffer 的行
(global-set-key (kbd "C-c C-s") 'consult-line)
;; SPC wi: 跳转到函数/类定义（imenu）
(vmacs-leader (kbd "wi") 'consult-imenu)

;;; ============================================================
;;; 第十八部分：Recentf 配置
;;; ============================================================
(defun vmacs-recentf-keep-p (file)
  "判断文件是否应该保留在最近文件列表中
保留：所有远程文件和本地可读文件"
  (cond
   ((file-remote-p file))      ;; 保留所有远程文件（Tramp）
   ((file-readable-p file))))  ;; 保留本地可读文件
(setq recentf-keep '(vmacs-recentf-keep-p))

;; 【记录目录】打开 dired 时也记录到 recentf
(defun recentf-track-opened-dir ()
  "将当前目录添加到 recentf 列表"
  (and default-directory
       (recentf-add-file default-directory)))
(add-hook 'dired-mode-hook #'recentf-track-opened-dir)

;;; ============================================================
;;; 第十九部分：Consult-dir 配置
;;; ============================================================
;; consult-dir: 快速切换目录的工具
;; 禁用项目列表（不使用 project.el 的项目）
(setq consult-dir-project-list-function #'(lambda()nil))

;; 【目录来源】
(setq-default consult-dir-sources
              '(consult-dir--source-default      ;; 默认目录
                consult-dir--source-recentf      ;; 最近访问的目录
                consult-dir--source-tramp-ssh))  ;; SSH 远程目录

;; 【快捷键】在 minibuffer 中切换目录
;; s-j / s-C-j: 切换目录
(define-key minibuffer-local-completion-map (kbd "s-C-j") #'consult-dir)
(define-key minibuffer-local-completion-map (kbd "s-j") #'consult-dir)
;; s-l / s-C-l: 在目录中查找文件
(define-key minibuffer-local-completion-map (kbd "s-C-l") #'consult-dir-jump-file)
(define-key minibuffer-local-completion-map (kbd "s-l") #'consult-dir-jump-file)
;; C-x d: 全局切换目录
(define-key global-map (kbd "C-x d") #'consult-dir)

;; 【配置】
(setq consult-dir-shadow-filenames nil)           ;; 不遮蔽文件名
(setq consult-dir-default-command #'consult-dir-dired)  ;; 默认打开 dired

;; 【自定义显示】使用简短文件名显示目录
(with-eval-after-load 'consult-dir
  (defvar consult-dir--source-project-items (plist-get consult-dir--source-project :items))
  (plist-put consult-dir--source-project
             :items #'(lambda() (mapcar #'vmacs-short-filename  (funcall consult-dir--source-project-items))))
  (plist-put consult-dir--source-recentf
             :items #'(lambda() (mapcar #'vmacs-short-filename  (consult-dir--recentf-dirs))))
  (plist-put consult-dir--source-default
             :items #'(lambda() (mapcar #'vmacs-short-filename  (consult-dir--default-dirs)))))

(provide 'conf-icomplete)

;; Local Variables:
;; coding: utf-8
;; End:

;;; conf-icomplete.el ends here.
