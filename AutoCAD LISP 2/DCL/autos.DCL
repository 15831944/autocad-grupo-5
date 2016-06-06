autos :dialog{
label = "Catedra de CAD AVANZADO - Bloques de Autos";
:row{
     :boxed_column {
     		   label = "autos";
     		   :list_box {
     		   	     key = "listas";
     		   	     width = 20;
     		             }
     		   :toggle{
     		             label = "Espejo en X... ";
     		             key = "espejo";
     		          }
     		   spacer;
                   }
     :boxed_radio_column{
     			label = "escoja una vista";
     			key = "valorradio";
     			:radio_button {
     				       label = "planta";
     				       key = "eleccion00";
     				      }
     		        :radio_button {
     		        	       label = "lateral";
     		        	       key ="eleccion01";
     		                      }
     		        :radio_button {
     		        	       label = "frontal";
     		        	       key ="eleccion02";
     		                      }
     		        :radio_button {
     		        	       label = "posterior";
     		        	       key ="eleccion03";
     		                      }
                        }
      :boxed_radio_column{
      			  label = "vista previa";
      			  :image{
		                      key = "imagen";
		                      width = 30;
		                      height = 8;
		                     }
      			 }
}
spacer;
spacer;
spacer;
ok_cancel;
}