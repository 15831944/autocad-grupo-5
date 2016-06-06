escaleraII : dialog{
	label = "Escalera de n pasos";
	:boxed_row{
	:boxed_column{
		label = "Datos";
		: edit_box{
		label="Tamaño de contrahuella";
		
		key = "contrahuella";
		width = 5;
		fixed_width = true;
		}
		: edit_box {
		label="Tamaño de la huella      ";
		key = "huella";
		width = 5;
		fixed_width= true;
		}
		: edit_box {
		label="Numero de escalones    ";
		key = "escalones";
		width = 5;
		fixed_width= true;
		}
	}
	:boxed_column{
		:icon_image{
		key = "imagen";
		width = 30;
		height = 8;
		}
	}
	}
	spacer;
	spacer;
	:button {
	label = "Punto de inicio";
	key = "punto";
	}
	spacer;
	spacer;
ok_cancel;
}