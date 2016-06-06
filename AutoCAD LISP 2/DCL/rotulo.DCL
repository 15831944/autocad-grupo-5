rotulo : dialog {

label = "CATEDRA DE CAD AVANZADO";
:row {
	:boxed_column {
  		    label = "Rotulo";
  		     key = "texto";
      			:edit_box {
         			   label = "Radio de la Circumferencia     ";
         			   key = "circunf";
         			   width = 30;
                                   }
                        :edit_box {
         			   label = "Numero con el que empieza    ";
         			   key = "NroIni";
         			   width = 30;
                                   }
			:edit_box {
         			   label = "Altura de texto                          ";
         			   key = "altura";
         			   width = 30;
                                   }                                   
                                   
                                   spacer;
                                   spacer;
                        :button {
                        	label = "Punto de Insercion";
                        	key = "punto";
                                }           
                                
                                   spacer;
                                   spacer;
                                   spacer;
                    }
         :boxed_column {
         		label = "Colores";
         		:boxed_column {
         		label = "Color ";
         		:button{
         		label = "circulo";
			key = "colcirc";
			width = 10;
			height = 2;
				   }}
			:boxed_column {	   
			label = "Color ";	   
		        :button{
         		label = "Text";
			key = "colctext";
			width = 10;
			height = 2;
				   }}
                       }
       }
       
  ok_cancel;
                }