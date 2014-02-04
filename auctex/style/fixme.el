;;; fixme.el --- AUC-TeX style file for FiXme

;; Copyright (C) 2000, 2002, 2004, 2006, 2009 Didier Verna

;; Author: Didier Verna <didier@didierverna.net>
;; Created: Tue Apr 18 14:49:29 2000
;; Keywords: tex abbrev data


;; This file is part of FiXme.

;; FiXme may be distributed and/or modified under the
;; conditions of the LaTeX Project Public License, either version 1.1
;; of this license or (at your option) any later version.
;; The latest version of this license is in
;; http://www.latex-project.org/lppl.txt
;; and version 1.1 or later is part of all distributions of LaTeX
;; version 1999/06/01 or later.

;; FiXme consists of all files listed in the file `README'.


;;; ckuehne: I have thrown out all the stuff that I do not need.

;;; Code:

(TeX-add-style-hook "fixme"
  (function
   (lambda ()
     (TeX-add-symbols
      '("fxsetup")

      '("fxnote"    ["Options"] "Annotation")
      '("fxwarning" ["Options"] "Annotation")
      '("fxerror"   ["Options"] "Annotation")
      '("fxfatal"   ["Options"] "Annotation")
      '("fixme"     ["Options"] "Annotation")

      '("fxnote*"    ["Options"] "Annotation" t)
      '("fxwarning*" ["Options"] "Annotation" t)
      '("fxerror*"   ["Options"] "Annotation" t)
      '("fxfatal*"   ["Options"] "Annotation" t)

      '("listoffixmes" 0)

      '("fxuselayouts"  t)
      '("fxloadlayouts" t)
      '("fxuseenvlayout"   t)
      '("fxloadenvlayouts" t)
      '("fxusetargetlayout"   t)
      '("fxloadtargetlayouts" t)

      '("fxsetface" "Face" "Value")

      '("FXRegisterAuthor" "Command prefix" "Environment prefix" "Tag")

      '("fxusetheme" "Theme")

      '("FXRegisterLayout"       "Name" "Macro")
      '("FXRegisterLayout*"      "Name" "Macro")
      '("FXRegisterEnvLayout"    "Name" "Opening macro" "Closing macro")
      '("FXRegisterTargetLayout" "Name" "Macro")

      '("FXRequireLayout"       "Name")
      '("FXRequireEnvLayout"    "Name")
      '("FXRequireTargetLayout" "Name")

      '("FXProvidesLayout"       "Name" ["Release information"])
      '("FXProvidesEnvLayout"    "Name" ["Release information"])
      '("FXProvidesTargetLayout" "Name" ["Release information"])

     

      )

     (LaTeX-add-environments
      '("anfxnote"    ["Options"] "Summary")
      '("anfxwarning" ["Options"] "Summary")
      '("anfxerror"   ["Options"] "Summary")
      '("anfxfatal"   ["Options"] "Summary")
      '("afixme"      ["Options"] "Summary")

      ;; #### NOTE: I would like to insert a couple of braces here.
      '("anfxnote*"    ["Options"] "Summary")
      '("anfxwarning*" ["Options"] "Summary")
      '("anfxerror*"   ["Options"] "Summary")
      '("anfxfatal*"   ["Options"] "Summary")))))



;;; Local variables:
;;; eval: (put 'TeX-add-style-hook 'lisp-indent-function 1)
;;; End:

;;; fixme.el ends here
