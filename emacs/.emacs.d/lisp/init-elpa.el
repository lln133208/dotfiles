;;=============================================
;; Package source configuration
;;=============================================

;; to use melpa-stable
(require 'package)
(setq package-archives '(("melpa-stable" . "http://elpa.emacs-china.org/melpa-stable/")
			 ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(package-initialize)
(provide 'init-elpa)
