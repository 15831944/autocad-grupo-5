;API
(defun tirilla (pt_i contorno_cuello)
  ;pt3 pt4     pt5 pt6
  ;pt2             pt7
  ;pt1             pt8
  (setq
    ;pt1 = pt_i
    pt2 (list (car pt_i) (+ (cadr pt_i) 1 ) )
    pt3 (list (car pt_i) (+ (cadr pt_i) 3 ) )
    pt4 (list (+ (car pt3) 2 ) (cadr pt3) )
    pt5 (list (+ (car pt_i) (- contorno_cuello 2 ) ) (cadr pt4) )
    pt6 (list (+ (car pt_i) contorno_cuello ) (cadr pt5) )
    pt7 (list (car pt6) (cadr pt2) )
    pt8 (list (car pt7) (cadr pt_i) )
    )
  (command "_pline" pt_i pt2 "A" "D" pt3 pt4 "L" pt5 "A" "D" pt6 pt7 "L" pt8 "C")
)

;wraper
(defun c:user_tirilla ()
  (setq
    _pt_i (getpoint "\nPunto de insercion: ")
    _contorno_cuello (getreal "\nContorno de cuello: ")
    )
  (tirilla _pt_i _contorno_cuello)
)
