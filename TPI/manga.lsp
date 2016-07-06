;API
(defun manga (pt_i contorno_de_sisa alto_de_sisa largo_de_manga)
  ;(setq oldLayer (getvar"CLAYER"))
  ;(capa "0")
  (setq
    ancho (- contorno_de_sisa 10)
    alto (+ (+ largo_de_manga alto_de_sisa ) 4)
    )
	;        pt3
	;    pt2     pt4
	;pta pt1        ptb
  (setq
    pt_f (list (+(car pt_i) ancho) (+(cadr pt_i) alto) )

    pta (list (car pt_i) (+ (cadr pt_i) (+ largo_de_manga 4) ) )
    pta_aux (list (+ (car pt_i) (* ancho 0.25)) (+ (cadr pt_i) (+ largo_de_manga 4) ) )
    ptb (list (+ (car pt_i) (* ancho 0.25)) (+ (cadr pta) (/ alto_de_sisa 2) ) )
    ptc (list (+ (car pt_i) (* ancho 0.50)) (+ (cadr pta) alto_de_sisa ) )
    ptd (list (+ (car pt_i) (* ancho 0.75)) (+ (cadr pta) (/ alto_de_sisa 2) ) )
    pte (list (car pt_f) (+ (cadr pt_i) (+ largo_de_manga 4) ) )

    pt1 (list (+ (car pt_i) (- ancho 2)) (+ (cadr pt_i) 4) )
    pt2 (list (+ (car pt_i) ancho) (+ (cadr pt_i) 2) )
    pt3 (list (+ (car pt_i) (- ancho 2)) (cadr pt_i) )
    pt4 (list (+ (car pt_i) 2) (cadr pt_i) )
    pt5 (list (car pt_i) (+ (cadr pt_i) 2) )
    pt6 (list (+ (car pt_i) 2) (+ (cadr pt_i) 4) )
    )
  (command "pline" pta "A" "D" pta_aux ptb ptc ptd pte "L" pt1 pt2 pt3 pt4 pt5 pt6 "C")
  ;(setq copa (entlast))
  ;(cambiar_capa_de_objeto copa oldLayer)
  ;(capa oldLayer)
)

;user
(defun c:user_manga ()
	(setq
		pt_i (getpoint "\nIngrese un punto de insercion: ")
		contorno_de_sisa (getreal "\nIngrese el contorno de sisa: ")
		alto_de_sisa (getreal "\nIngrese el alto de la sisa: ")
		largo_de_manga (getreal "\nIngrese el largo de manga: ")
	)
	(manga pt_i contorno_de_sisa alto_de_sisa largo_de_manga)
)
