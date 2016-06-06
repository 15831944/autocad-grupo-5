(DEFUN c:ROTULO ()
  (wHILE 
  (ROT)
  )
)


(defun rot	()
  (setq	valor_diamt nil	valor_NROINI nil valor_INCR nil	valor_alt nil p1 nil	n 0
  )
  (setq cuadro (load_dialog "d:/facultadI/dcl/rotulo.dcl"))
  (if (not (new_dialog "rotulo" cuadro))
    (exit)
  )
;;;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  (set_tile "circunf" "10")
  (mode_tile "circunf" 2)
  (action_tile "circunf" "(setq valor_diamt $value)")
  (action_tile "NroIni" "(setq valor_NROINI $value)")
  (action_tile "altura" "(setq valor_alt $value)")
  (action_tile "colcirc" "(setq ncolor (acad_colordlg 1))")
  (action_tile "colctext" "(setq ntexto (acad_colordlg 1))")
  (action_tile "punto" "(done_dialog 2)")
;;;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  (setq venta_gnl (start_dialog))
  (unload_dialog cuadro)
  (if (= venta_gnl 2) (tpunto))
;;;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  (SETQ	DIAM   valor_diamt
	NROI   valor_NROINI
	altura valor_alt
  )
  (SETQ	DIAM   (atof diam)
	NROI   (atoi nroi)
	altura (atof altura)
  )
  (command "circle" p1 DIAM)
  (command "_change" "l" "" "p"  "c" ncolor """")
  (command "text" "j" "m" p1 altura 0 NROI)
  (command "_change" "l" "" "p"  "c" ntexto """")
  (princ)
)
(defun tpunto()
    (setq p1 (getpoint "\nCentro de la circunferencia"))
)
