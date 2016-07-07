;API
(defun manga (pt_i contorno_sisa alto_sisa largo_manga)
  ;(setq oldLayer (getvar"CLAYER"))
  ;(capa "0")
  (setq
    ancho (- contorno_sisa 10)
    alto (+ (+ largo_manga alto_sisa ) 4)
    )
	;        ptc
	;    ptb     ptd
	;pta pta_aux    pte
  (setq
    pt_f (list (+(car pt_i) ancho) (+(cadr pt_i) alto) )

    pta (list (car pt_i) (+ (cadr pt_i) (+ largo_manga 4) ) )
    pta_aux (list (+ (car pt_i) (* ancho 0.25)) (+ (cadr pt_i) (+ largo_manga 4) ) )
    ptb (list (+ (car pt_i) (* ancho 0.25)) (+ (cadr pta) (/ alto_sisa 6) ) )
    ptc (list (+ (car pt_i) (* ancho 0.50)) (+ (cadr pta) (/ alto_sisa 3) ) )
    ptd (list (+ (car pt_i) (* ancho 0.75)) (+ (cadr pta) (/ alto_sisa 6) ) )
    pte (list (car pt_f) (+ (cadr pt_i) (+ largo_manga 4) ) )

    pt1 (list (+ (car pt_i) (- ancho 2)) (+ (cadr pt_i) 4) )
    pt2 (list (+ (car pt_i) ancho) (+ (cadr pt_i) 2) )
    pt3 (list (+ (car pt_i) (- ancho 2)) (cadr pt_i) )
    pt4 (list (+ (car pt_i) 2) (cadr pt_i) )
    pt5 (list (car pt_i) (+ (cadr pt_i) 2) )
    pt6 (list (+ (car pt_i) 2) (+ (cadr pt_i) 4) )
    )
  (command "pline" pta "A" "D" pta_aux ptb ptc ptd pte "L" pt1 pt2 pt3 pt4 pt5 pt6 "C")
  ;(setq copa (entlast))
  ;(cambiar_capa_objeto copa oldLayer)
  ;(capa oldLayer)
)

;user
(defun c:user_manga ()
	(setq
		_pt_i (getpoint "\nIngrese un punto de insercion: ")
		_contorno_sisa (getreal "\nIngrese el contorno de sisa: ")
		_alto_sisa (getreal "\nIngrese el alto de la sisa: ")
		_largo_manga (getreal "\nIngrese el largo de manga: ")
	)
	(manga _pt_i _contorno_sisa _alto_sisa _largo_manga)
)
