(defun c:ec ()
  (setq nro (getint "\nIngrese el valor de X... ");;;Valor entero
	y (+ (* 5 nro) 2)
  )
  (setq resp (strcat "Resultado: " (itoa y)))
  (alert resp)
)

;;;XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
(defun c:ec ()
  (setq nro (getreal "\nIngrese el valor de X... ");;;Valor real
	y (+ (* 5 nro) 2)
  )
  (setq resp (strcat "Resultado: " (rtos y)))
  (alert resp)
)