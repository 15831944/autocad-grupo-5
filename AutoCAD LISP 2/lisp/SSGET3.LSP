(DEFUN C:SS3 ()
  (alert "Seleccione las entidades para cambiar a la capa AUX")
  (SETQ ENT (SSGET "x" '((0 . "CIRCLE"))))
  (command "change" ent "" "p" "la" "aux" "")
)

