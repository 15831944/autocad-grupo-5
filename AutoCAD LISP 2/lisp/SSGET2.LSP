(DEFUN C:SS2 ()
  (alert "Seleccione las entidades para cambiar a la capa AUX")
  (SETQ ENT (SSGET "x"))
  (command "change" ent "" "p" "la" "aux" "")
)

