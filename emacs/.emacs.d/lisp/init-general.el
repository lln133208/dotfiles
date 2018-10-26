;;=============================================
;; Global configuration
;;=============================================


;; frame title
(setq frame-title-format "Editor for God @%b")

;; make emacs frame fullscreen on start-up
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; enable highlighting current line
;;(global-hl-line-mode 1)

;; line number in left
(global-linum-mode 1)

;; display line number and column number in mode zone
(setq column-number-mode 1)
(setq line-number-mode 1)

;; disable startup message
(setq inhibit-startup-message 1)
(setq qnus-inhibit-startup-message 1)

;; display current time
(display-time)
(setq display-time-24hr-format 1)
(setq display-time-day-and-date 1)
(setq displat-time-interval 10)

;; disable menu bar
;; nil doesn't work, must be 0
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; buffer size of kill ring
(setq kill-ring-max 200)

;; disable auto-backup
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; replace yes/no with y/n
(fset 'yes-or-no-p 'y-or-n-p)

(provide 'init-general)
