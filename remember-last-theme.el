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
;; Usage:
;;  (require 'remember-last-theme)
;;
;;; Code:
(require 'cus-edit)

(defun remember-last-theme-save ()
  "Save the current theme for next sessions."
  (interactive)
  (customize-save-variable 'custom-enabled-themes custom-enabled-themes))

(add-hook 'kill-emacs-hook 'remember-last-theme-save)
(add-hook 'after-init-hook (lambda () (load custom-file)))

(provide 'remember-last-theme)
;;; remember-last-theme.el ends here
