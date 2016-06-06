(DEFUN C:SS1 ()
  (alert "Seleccione las entidades para cambiar a la capa AUX")
  (SETQ ENT (SSGET))
  (command "change" ent "" "p" "la" "aux" "")
)


