(defun c:textos	()
  (setq	t1     "FACULTAD"
	LARGO  (STRLEN T1)
	MINUS  (strcase t1 t)
	corte  (substr t1 2 5)
	t2     " DE INGENIERIA"
	JUNTAR (STRCAT t1 t2)
	T4 "FACULTAD DE INGENIERIA"
	T5 (READ T4); esto es un SYM
	T6 "50,65 m2"
	t7 (read t6)
  )
)