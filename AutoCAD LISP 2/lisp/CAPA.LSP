(DEFUN C:CAPA ()
  (ENTMAKE (LIST
	     (CONS 0 "LAYER")
	     (CONS 100 "AcDbSymbolTableRecord")
	     (CONS 100 "AcDbLayerTableRecord")
	     (CONS 2 "FICH")
	     (CONS 70 0)
	     (CONS 62 1)
	     (CONS 6 "CONTINUOUS")
	   )
  )	   
)