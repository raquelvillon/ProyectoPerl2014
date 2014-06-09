use utf8; #permite que se compilen caracteres especiales como las vocales tildadas y las eñes

open (datos,"<:encoding(UTF-8)","dataset.txt"); #hace que lea el txt tal y como esta escrito, incluidas los caracteres esperciales
	@informacion=<datos>; #guarda cada linea dentro del arreglo "@informacion"
close (datos);

#todos los resultados se imprimirán aquí 
open (sal,">salida.txt");
	#guarda solo las lineas que tienen texto, se salta las lineas en blanco
	foreach $inf(@informacion){
		if (length($inf)>2) {
			push(@parrafos,$inf);
			#funciones para buscar información
			buscaNombre($inf);
			buscaEdad($inf);
			buscarEstudios($inf);
			buscarEstatura($inf);
			buscarPeso($inf);
			buscarTelefono($inf);
			buscarEstadoCivil($inf);
			buscarCiudadNatal($inf);
			
			print sal "\n\n";
	}
	}
close (sal);

#Funcion que busca los nombres en el dataset
sub buscaNombre {
	$nom=$_[0];
	if ($nom =~ /(nombre es |llamo )([A-Za-záéíóÁÉÍÓÚ\s]+)*/) {
		$nombre=$2;
		if($nombre=~/([A-Za-záéíóúÁÉÍÓÚS\s]+)*(tengo|nac[íi])/){
		print sal "Nombre: ".$1."\n";
		}else{
			print sal "Nombre: ".$nombre."\n";
		}
		
	}
}

#Funcion que busca las edades en el dataset
sub buscaEdad {
	$nom=$_[0];
	if ($nom =~ /[tT]engo ([0-9\s]+)* [aA]ños/) {
		print sal "Edad: ".$1."\n";
	}
}

#Funcion que busca La universidad y la carrera en el dataset  #################################################################
sub buscarEstudios {
	$nom=$_[0];
	if ($nom =~ /([eE]studi[oeé] |estudiante )([A-Za-záéíóÁÉÍÓÚS,.\s]+)*/) {
		$estudios=$2;
		#print sal $2."\n";
		
		if($estudios=~/([Ii]ngenier[íi]a|Ing\.)([A-Za-záéíóÁÉÍÓÚS\s]+)*/){
			$carrera=$2;
			if($carrera=~/([A-Za-záéíóÁÉÍÓÚS\s]+)*(en ESPOL|en la Escuela|en la ESPOL)/){
				print sal "Carrera:  Ingeniería $1 \n"
			}else{
				print sal "Carrera:  Ingeniería $carrera \n"
			}
			
			
		}elsif(/(carrera (es|de estudio|de))([A-Za-záéíóÁÉÍÓÚS\s]+)*/){
			$carrera=$2;
			if($carrera=~/([A-Za-záéíóÁÉÍÓÚS\s]+)*(en ESPOL|en la Escuela|en la ESPOL)/){
				print sal "Carrera:  Ingeniería $1 \n"
			}else{
				print sal "Carrera:  $carrera \n"
			}
		}elsif($estudios=~/[Ll]eyes/){
			print sal "Carrera:  Leyes \n"
		}
		if($estudios=~/([Ee][Ss][Pp][Oo][Ll]|Escuela)/){
			print sal "Universidad: ESPOL \n"
		}elsif($estudios=~/([Cc][Aa][Tt][Oo][Ll][Ii][Cc][Aa]|[Uu][Cc][Ss][Gg])/){
			print sal "Universidad: Católica \n"
		}elsif($estudios=~/([Ee]statal|[Uu]niversidad de [Gg]uayaquil)/){
			print sal "Universidad: Estatal \n"
		}

		
	}
}


sub buscarPeso {
	$peso=$_[0];
	#Encuentra los pesos en kilogramos
	if ($peso =~ /([pP]eso |al rededor de |aproximadamente |mi peso es )([0-9]{2})+(kg| kg|kilogramos| kilogramos)*/){
		print sal "Peso: ".$2." kilogramos\n";
	}
	#Encuentra las estaturas en libras y las convierte a kilogramos
	if ($peso =~ /([pP]eso |al rededor de |aproximadamente |mi peso es )([0-9]{3})+(lb| lb|libras| libras)*/){
		$datopeso = $2*(0.45);
		print sal "Peso: ".$datopeso." kilogramos\n";
	}	
	#print "\n";	
}

sub buscarTelefono{
	$telf=$_[0];
	#Encuentra los telefonos en formato internacional
	if ($telf =~ /([cC]elular al )([+][5][9][3][ ][0-9]{8})*/){
		print sal "Telefono: ".$2."\n";
	}
	
	#Encuentra los telefonos celulares
	if ($telf =~ /([cC]elular es |[cC]elular al |[cC]elular |[tT]el[ée]fono es |[tT]el[ée]fono |[tT]elef[óo]nico es el )([0-9]{10})*/){
		print sal "Telefono: ".$2."\n";
	}
	
	#Encuentra los telefonos fijos
	if ($telf =~ /([tT]el[ée]fono es )([2-9]{7})*/){
		print sal "Telefono: ".$2."\n";
	}	}

sub buscarEstadoCivil{
	$estadoCiv=$_[0];
	#Encuentra los estados civil
	if ($estadoCiv =~ /([Ss]oy |[Ee]stoy |[Mm]e encuentro )(solter[oa])/){
		print sal "Estado Civil: ".$2."\n";
	}
	if ($estadoCiv =~ /([Ss]oy |[Ee]stoy |[Mm]e encuentro )(casad[oa])/){
		print sal "Estado Civil: ".$2."\n";
	}	}sub buscarEstatura {
	$estatura=$_[0];
	#Encuentra las estaturas en metros
	if ($estatura =~ /([mM]ido |[mM]i estatura es de |[mM]i estatura es |[mM]ido aproximadamente )([1]+\.)+([0-9]{2}|[0-9])+(m| m|metros| metros)*/){
		$datoestatura = $2.$3;
		if (length($datoestatura)<4){
			$datoestatura = $datoestatura."0";
		}
		print sal "Estatura: ".$datoestatura." metros\n";
		#print sal "Estatura: ".$2.$3." metros\n";
	}
	#Encuentra las estaturas en centimetros
	if ($estatura =~ /([mM]ido |[mM]i estatura es de |[mM]i estatura es |[mM]ido aproximadamente )([0-9]{3})+(cm| cm|centimetros| centimetros)*/){
		$datoestatura = $2/100;
		print sal "Estatura: ".$datoestatura." metros\n";
	}}
sub buscarCiudadNatal {
	$nom=$_[0];
	if ($nom =~ /(nac[íi] (en|el|)|mi ciudad natal|lugar de nacimiento es (en|))([0-9A-Za-záéíóÁÉÍÓÚñ\.\s]+)*/) {
		$nombre=$4;
		
		if($nombre=~/[Gg]uayaquil/){
			print sal "Ciudad de Nacimiento: Guayaquil \n";
		}elsif ($nombre=~/[Bb]abahoyo/){
			print sal "Ciudad de Nacimiento: Babahoyo \n";
		}elsif ($nombre=~/[Ll]oja/){
			print sal "Ciudad de Nacimiento: Loja \n";
		}elsif ($nombre=~/[Qq]uito/){
			print sal "Ciudad de Nacimiento: Quito \n";
		}elsif ($nombre=~/[Cc]uenca/){
			print sal "Ciudad de Nacimiento: Cuenca \n";
		}
		
	}
}

