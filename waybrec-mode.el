;;; waybrec-mode.el --- A major mode for editing Waybrec  -*- lexical-binding: t; -*-

;; Copyright © 2019-2022 Michael Allan.
;;
;; Author: Michael Allan <mike@reluk.ca>
;; Version: 0-snapshot
;; SPDX-License-Identifier: MIT
;; Package-Requires: (brec-mode (emacs "24.3"))
;; Keywords: outlines, wp
;; URL: http://reluk.ca/project/wayic/Waybrec/Emacs/
;;
;; This file is not part of GNU Emacs.
;;
;; This file is released under an MIT licence.  A copy of the licence normally accompanies it.
;; If not, then see `http://reluk.ca/project/wayic/Waybrec/Emacs/LICENCE.txt`.

;;; Commentary:

;;   This package introduces a major mode (`waybrec-mode`) for editing Waybreccian text.
;;   For more information, see `http://reluk.ca/project/wayic/Waybrec/Emacs/`.
;;
;; Installation
;;
;;   If you install this package using a package manager, then it takes one more step to complete
;;   the installation.  Add the following to your initialization file.
;;   https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html
;;
;;     (set 'auto-mode-alist (cons (cons "/way/.*\\.brec\\'" 'waybrec-mode) auto-mode-alist))
;;
;;   Ensure the regular expression above captures the path to your waysource files.  Then `waybrec-mode`
;;   will activate on loading any of them into Emacs.  And that completes the installation.
;;
;;   Manual installation, on the other hand, requires further steps:
;;
;;       1. Put a copy of `waybrec-mode.el` on your load path.
;;          https://www.gnu.org/software/emacs/manual/html_node/elisp/Library-Search.html
;;
;;       2. Optionally compile that copy.  E.g. load it into an Emacs buffer and type
;;          `M-x emacs-lisp-byte-compile`.
;;
;;       3. Add the following code to your initialization file.
;;
;;             (autoload 'waybrec-mode "waybrec-mode" nil t)
;;
;;          Ensure too that `auto-mode-alist` is set, as described further above.
;;
;;   For a working example of manual installation, see the relevant lines of the file
;;   `http://reluk.ca/.config/emacs/lisp/initialization.el`.

;;; Code:

(require 'brec-mode)



(defgroup waybrec nil
  "A major mode for editing Waybreccian text."
  :group 'text
  :prefix "waybrec-"
  :link '(url-link "http://reluk.ca/project/wayic/Waybrec/Emacs/"))



(defconst waybrec--gap-pattern; Incomplete, deprecated in favour of `brec-gap-pattern`. [BUG]
  "[ \n]+"
  "The regular-expression pattern of a gap in a descriptor.")



;;;###autoload
(define-derived-mode waybrec-mode brec-mode
  "Waybrec"
  "A major mode for editing Waybreccian text.
For more information, see URL ‘http://reluk.ca/project/wayic/Waybrec/Emacs/’."
  :group 'waybrec

  (let* ((pattern-matcher brec-pattern-matcher-pattern)
         (end brec-term-end-boundary-pattern); To reject any command keyword directly followed by
           ;;; further term characters, e.g. the misplaced delimiter ‘:’ of an appendage clause.
         (gap waybrec--gap-pattern)
         (mc (copy-sequence brec-command-matcher-components)); So isolating from any other
           ;;; `brec-mode` buffer the (deep) changes about to be introduced to this list.
         (mc-new (last mc 2))); The component after which to insert new components.

    ;; Patch (defunct and deprecated)
    ;; ─────
    (push (concat "\\|\\(?1:prepend\\|append\\)" gap "@" gap pattern-matcher) (cdr mc-new));
    (push (concat "\\|\\(?1:delete\\|precede\\|succeed\\)" gap pattern-matcher) (cdr mc-new));
    (push (concat "\\|\\(?1:replace\\)" end) (cdr mc-new));

    ;; Thoroughfractum designator
    ;; ──────────────────────────
    (push (concat "\\|\\(?1:thoroughfractum\\)\\>" end) (cdr mc-new))

    (setq-local brec-command-matcher-components mc))
      ;;; Locally isolating from any other `brec-mode` buffer the (shallow) change to this variable.
  (brec-set-for-buffer 'font-lock-defaults '(brec-keywords)))



(provide 'waybrec-mode)


;; NOTE
;; ────
;;   BUG  This code is incorrect.


;;; waybrec-mode.el ends here
