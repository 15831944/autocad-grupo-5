(DEFUN C:SS4 ()
  (alert "Seleccione las entidades para cambiar a la capa AUX")
  (SETQ ENT (SSGET '((0 . "CIRCLE"))))
  (command "change" ent "" "p" "la" "aux" "")
)

