;;=============================================
;; Global configuration
;;=============================================


;; frame title
(setq frame-title-format "Editor for God @%b")

;; enable highlighting current line
(global-hl-line-mode t)

;; line number in left
(global-linum-mode t)

;; display line number and column number in mode zone
(setq column-number-mode t)
(setq line-number-mode t)

;; disable startup message
(setq inhibit-startup-message t)
(setq qnus-inhibit-startup-message t)

;; display current time
(display-time)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
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

(provide 'init-general)
