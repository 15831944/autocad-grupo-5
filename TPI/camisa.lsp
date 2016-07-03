(defun LoadDialog_no_name( / dcl_id)
   (defun init_handler()   ;Initialation_Code
       (princ)
   );End of Initial Function
   (defun set_data() ;Start Set function
       (princ)
   );End of Set function
   (defun get_data() ;Start Get function
       (princ)
   );End of Get function
   (if (setq dcl_id (load_dialog "camisa.dcl"))
       (if (new_dialog "no_name" dcl_id)
           (progn
              (setq result nil)
              (init_handler)
              (set_data)
              (action_tile "accept" "(get_data)(done_dialog)(setq result T)")
              (start_dialog)
              (unload_dialog dcl_id)
              result
            )
        )
    )
)

(defun c:camisas ()
  ;(LoadDialog_no_name)
  )