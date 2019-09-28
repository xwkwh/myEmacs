
(evil-leader/set-key "b" 'evil-search-highlight-persist-remove-all)
(evil-leader/set-key "SPC"   'ivy-switch-buffer)
(autoload 'dired-jump "dired-x" "dired-jump" t)
(evil-leader/set-key "j" 'dired-jump) ;; 跳到当前目录文件
(evil-leader/set-key "s" 'evil-write-all) ;; 保存全部  
(evil-leader/set-key  "ff" 'counsel-find-file)
(evil-leader/set-key  "ft" #'(lambda()(interactive)(let ((default-directory "/tmp/"))(call-interactively 'counsel-find-file))))
(evil-leader/set-key  "fh" #'(lambda()(interactive)(let ((default-directory "~"))(call-interactively 'counsel-find-file))))
(evil-leader/set-key "g" 'vmacs-counsel-rg) ;; 搜索当前目录下 根据单词 + 空格


(provide 'conf-keybind)
