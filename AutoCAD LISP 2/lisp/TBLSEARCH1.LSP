(DEFUN C:TBL1 ()
  (alert "Seleccione las entidades para cambiar a la capa FICH")
  (SETQ ENT (SSGET '((0 . "CIRCLE"))))
  (if (tblsearch "LAYER" "FICH")
    (command "change" ent "" "p" "la" "FICH" "c" "bylayer" "")
    (COMMAND "layer" "m" "fich" "c" "4" "" ""
	     "change" ent "" "p" "la" "FICH" "c" "bylayer" "")
  )  
)