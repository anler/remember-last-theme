;;; remember-last-theme.el --- Remember the last used theme between sessions.
;;
;; Author: Anler Hernández Peral <inbox+emacs@anler.me>
;; Maintainer: Anler Hernández Peral <inbox+emacs@anler.me>
;; Created: 26 Feb 2017
;; Version: 1.0.0
;; Keywords: convenience faces
;; URL: https://github.com/anler/remember-last-theme
;; Package-Requires: ((emacs "24.4"))
;;
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;; Remember the last used theme between Emacs sessions. Each time you
;; select a theme, it's saved into a file that is read and activated
;; the next time you open Emacs.
;;
;; Customizable options are:
;;  remember-last-theme-filename
;;
;; Usage:
;;  (require 'remember-last-theme)
;;
;;; Code:

(defgroup remember-last-theme nil
  "Remember the last used theme."
  :group 'customize)

(defcustom remember-last-theme-filename
  (format "%s%s" user-emacs-directory "remember-last-theme.txt")
  "Filename where the current theme is saved."
  :group 'remember-last-theme)

(advice-add 'load-theme :after #'remember-last-theme-save-theme)
(advice-add 'disable-theme :after #'remember-last-theme-save-default-theme)

(defun remember-last-theme-save-default-theme (disabled-theme)
  (remember-last-theme-save-theme 'default))

(defun remember-last-theme-save-theme (theme &optional no-confirm no-enable)
  (with-temp-buffer
    (insert (symbol-name theme))
    (if (file-writable-p remember-last-theme-filename)
      (write-region (point-min)
                    (point-max)
                    remember-last-theme-filename)
      (message "`remember-last-theme-filename' is not writable!"))))

(defun remember-last-theme-load-saved-theme ()
  (interactive)
  (if (file-exists-p remember-last-theme-filename)
    (let ((theme (intern (with-temp-buffer
                           (insert-file-contents remember-last-theme-filename)
                           (buffer-string)))))
      (unless (eq theme 'default)
        (load-theme theme :no-confirm)))
    (message "Couldn't load saved theme. `remember-last-theme-filename' not found.")))

(add-hook 'after-init-hook #'remember-last-theme-load-saved-theme)

(provide 'remember-last-theme)
;;; remember-last-theme.el ends here
