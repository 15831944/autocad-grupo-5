;user
(defun c:manga ()
	(load "auxiliares.lsp" "\nNo se pudo cargar la libreria de funciones")
	(setq
		pt_i (getpoint "\nIngrese un punto de insercion: ")
		contorno_de_sisa (getreal "\nIngrese el controno de sisa: ")
		alto_de_sisa (getreal "\nIngrese el alto de la sisa: ")
		largo_de_manga (getreal "\nIngrese el largo de manga: ")
	)
	(setq oldLayer (getvar "CLAYER"))
	(capa "0")
	(setq
		ancho (- contorno_de_sisa 10)
		alto (+ (+ largo_de_manga alto_de_sisa ) 4)
	)
	(setq pt_f (list (+(car pt_i) ancho) (+(cadr pt_i) alto) ) )
	(command "rectangle" pt_i pt_f)
	;        pt3
	;    pt2     pt4
	;pta pt1        ptb
	(setq
		pta (list (car pt_i) (+ (cadr pt_i) (- alto alto_de_sisa) ) )
		ptb (list (car pt_f) (+ (cadr pt_i) (- alto alto_de_sisa) ) )
	)
	(setq
		pt1 (list (+ (car pta) (* ancho 0.25)) (cadr pta) )
		pt2 (list (+ (car pta) (* ancho 0.25)) (+ (cadr pta) (/ alto_de_sisa 2) ) )
		pt3 (list (+ (car pta) (* ancho 0.50)) (+ (cadr pta) alto_de_sisa ) )
		pt4 (list (+ (car pta) (* ancho 0.75)) (+ (cadr pta) (/ alto_de_sisa 2) ) )
		pt5 (list (+ (car pt_i) (- ancho 2)) (+ (cadr pt_i) 4) )
		pt6 (list (+ (car pt_i) ancho) (+ (cadr pt_i) 2) )
		pt7 (list (+ (car pt_i) (- ancho 2)) (cadr pt_i) )
		pt8 (list (+ (car pt_i) 2) (cadr pt_i) )
		pt9 (list (car pt_i) (+ (cadr pt_i) 2) )
		pt10 (list (+ (car pt_i) 2) (+ (cadr pt_i) 4) )
	)
	(command "pline" pta "A" "D" pt1 pt2 pt3 pt4 ptb "L" pt5 pt6 pt7 pt8 pt9 pt10 pta "" )
	(setq poli (entlast))
	(cambiar_capa_de_objeto poli oldLayer)
	(limpiar_capa_cero )
	(capa oldLayer)
)

;API
(defun manga (pt_i contorno_de_sisa alto_de_sisa largo_de_manga)
	(load "auxiliares.lsp" "\nNo se pudo cargar la libreria de funciones")
	(setq oldLayer (getvar "CLAYER"))
	(capa "0")
	(setq
		ancho (- contorno_de_sisa 10)
		alto (+ (+ largo_de_manga alto_de_sisa ) 4)
	)
	(setq pt_f (list (+(car pt_i) ancho) (+(cadr pt_i) alto) ) )
	(command "rectangle" pt_i pt_f)
	;        pt3
	;    pt2     pt4
	;pta pt1        ptb
	(setq
		pta (list (car pt_i) (+ (cadr pt_i) (- alto alto_de_sisa) ) )
		ptb (list (car pt_f) (+ (cadr pt_i) (- alto alto_de_sisa) ) )
	)
	(setq
		pt1 (list (+ (car pta) (* ancho 0.25)) (cadr pta) )
		pt2 (list (+ (car pta) (* ancho 0.25)) (+ (cadr pta) (/ alto_de_sisa 2) ) )
		pt3 (list (+ (car pta) (* ancho 0.50)) (+ (cadr pta) alto_de_sisa ) )
		pt4 (list (+ (car pta) (* ancho 0.75)) (+ (cadr pta) (/ alto_de_sisa 2) ) )
		pt5 (list (+ (car pt_i) (- ancho 2)) (+ (cadr pt_i) 4) )
		pt6 (list (+ (car pt_i) ancho) (+ (cadr pt_i) 2) )
		pt7 (list (+ (car pt_i) (- ancho 2)) (cadr pt_i) )
		pt8 (list (+ (car pt_i) 2) (cadr pt_i) )
		pt9 (list (car pt_i) (+ (cadr pt_i) 2) )
		pt10 (list (+ (car pt_i) 2) (+ (cadr pt_i) 4) )
	)
	(command "pline" pta "A" "D" pt1 pt2 pt3 pt4 ptb "L" pt5 pt6 pt7 pt8 pt9 pt10 pta "" )
	(setq poli (entlast))
	(cambiar_capa_de_objeto poli oldLayer)
	(limpiar_capa_cero )
	(capa oldLayer)
)
