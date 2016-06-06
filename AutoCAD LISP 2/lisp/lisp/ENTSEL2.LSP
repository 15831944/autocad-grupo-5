(DEFUN C:EJ ()
  (ALERT "SELECCIONE LA ENTIDAD BASE")
  (SETQ capa (CDR (ASSOC 8 (ENTGET (CAR (ENTSEL ))))))
  (ALERT (STRCAT "La entidad seleccionada pertenece a la capa: " capa))
  (prompt "\nSeleccione las entidades para cambiar de capa")
  (setq ss (ssget)
	SSLARGO (SSLENGTH SS)
	CONTADOR 0
  )
  (REPEAT SSLARGO
    (SETQ ENTIDAD (ENTGET (SSNAME SS CONTADOR)))

  )






	   
;;;  (command "change" ss "" "p" "la" capa "")
  (princ)
)