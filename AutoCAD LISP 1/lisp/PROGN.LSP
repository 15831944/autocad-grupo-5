(defun c:val (/ resp)
  (initget "A B")
  (setq resp (getkword "Digite alguna opcion... "))
  (if (= resp "A")
    (progn
      (setq resp2 (strcat "Respuesta: " resp))
      (alert resp2)
    )
    (progn
      (setq resp2 (strcat "Respuesta: " resp))
      (alert resp2)
    )
  )  
)
