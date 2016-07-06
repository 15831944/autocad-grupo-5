;API
(defun solapa (pt_i contorno_cuello)
  (setq
    alto 7
    ancho (- contorno_cuello 3)
    pt2 (list (+ (car pt_i) 1.5 ) (+ (cadr pt_i) alto) )
    pt3 (list (+ (car pt_i) (/ ancho 2) ) (+ (cadr pt_i) 4) )
    pt4 (list (+ (car pt_i) (- ancho 1.5) ) (cadr pt2) )
    pt5 (list (+ (car pt_i) ancho ) (cadr pt_i) )
    pt_dir_izq (list (- (car pt3) (/ ancho 2) ) (cadr pt3) )
    pt_dir_der (list (+ (car pt3) (/ ancho 2) ) (cadr pt3) )
    )
  (command "_pline" pt3 "A" "D" pt_dir_izq pt2 "L" pt_i pt5 pt4 "")
  (setq obj_a (entlast))
  (command "_pline" pt3 "A" "D" pt_dir_der pt4 "")
  (command "pedit" (entlast) "J" obj_a "" "")
)

;wraper
(defun c:user_solapa ()
  (setq
    _pt_i (getpoint "\nPunto de insercion: ")
    _contorno_cuello (getreal "\nContorno de cuello: ")
    )
  (solapa _pt_i _contorno_cuello)
)
