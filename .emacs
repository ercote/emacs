(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(default-abbrev-mode t t)
 '(delete-selection-mode t)
 '(fringe-mode 0 nil (fringe))
 '(scroll-bar-mode nil)
 '(scroll-conservatively 1)
 '(tool-bar-mode nil)
 '(truncate-lines t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

(add-to-list 'load-path "~/Dropbox/.emacs.d/")
(load "lisp-emacs-lisp-package")
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;(require 'slime)
;;(eval-after-load 'slime '(setq slime-protocol-version 'ignore))
;;(slime-setup '(slime-repl))


;;(ido-mode nil)
(iswitchb-mode t) ;; <-- prefer iswitchb
 
(defun edc/duplicate-line ()
  "Dupliquer la ligne."
  (interactive)
  (let ((original-column (current-column))
        line-content)
    (setq line-content (buffer-substring
                        (line-beginning-position)
                        (line-end-position)))
    (beginning-of-line)
    (newline +1)
    (forward-line -1)
    (insert line-content)
    (goto-column original-column)))
 
(defun edc/switch-window-buffer ()
  "Rotate buffers in the current window and window returned 
by `next-window'. Current buffer stays selected."
  (interactive)
  (if (not (equal (frame-selected-window) (next-window)))
      (let ((my-next-buffer (window-buffer (next-window))))
 (set-window-buffer (next-window) (window-buffer))
 (set-window-buffer nil my-next-buffer)
 (select-window (next-window)))))
 
(defun edc/insert-xhtml-reference (char)
  (interactive "cCharacter : ")
  (if char
      (insert (format "&#%d;" char))))
  
(global-set-key [(control tab)] 'edc/switch-window-buffer)
(global-set-key (kbd "C-=") 'edc/duplicate-line)
(global-set-key "\C-x\C-m" 'execute-extended-command)

(global-set-key "\M-7" '(lambda () (interactive) (insert "{")))
(global-set-key "\M-8" '(lambda () (interactive) (insert "}")))
(global-set-key "\M-9" '(lambda () (interactive) (insert "[")))
(global-set-key "\M-0" '(lambda () (interactive) (insert "]")))

(if (eq system-type 'windows-nt)
    (progn
      (global-set-key "\C-c\M-w" 'kill-ring-save)
      (global-set-key "\C-v" 'yank)
      (global-set-key "\M-v" 'yank-pop)
      (global-set-key "\C-z" 'undo)))

;; Mac OS X emacs/aquamacs
(if (eq system-type 'darwin)
    (progn
      (if (featurep 'aquamacs)
	  (progn 
	    (setq ns-right-alternate-modifier nil)
	    (setq ns-alternate-modifier 'meta))
	(progn ;; else
	  (setq mac-option-key-is-meta t)))
      ;; we need the alt key on a french keyboard to enter
      ;; these characters on Mac OS X, so I remap them to 
      ;; use C-c instead      
      (global-set-key "\C-c7" (lambda () (interactive) (insert "{")))
      (global-set-key "\C-c8" (lambda () (interactive) (insert "}")))
      (global-set-key "\C-c9" (lambda () (interactive) (insert "[")))
      (global-set-key "\C-c0" (lambda () (interactive) (insert "]")))
      (global-set-key "\C-c," (lambda () (interactive) (insert "<")))
      (global-set-key "\C-c." (lambda () (interactive) (insert ">")))
      (global-set-key "\C-cç" (lambda () (interactive) (insert "~")))
      (global-set-key "\C-c/" (lambda () (interactive) (insert "|")))
      (global-set-key "\C-cz" (lambda () (interactive) (insert "«")))
      (global-set-key "\C-cx" (lambda () (interactive) (insert "»")))      
      ;; emacs doesn't recognize movement using the command key on
      ;; Mac OS X...we map it here.
      (global-set-key (kbd "s-<left>") 'beginning-of-visual-line)
      (global-set-key (kbd "s-<right>") 'end-of-visual-line)
      (global-set-key (kbd "s-<up>") 'beginning-of-buffer)
      (global-set-key (kbd "s-<down>") 'end-of-buffer)))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)