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
		}
	}
	#numero de lineas a analizar
	$numParrafos=scalar(@parrafos);

	#analisis de las lineas o parrafos 
	for ($var = 0; $var < $numParrafos; $var++) {
		
				#separa las oraciones dentro de los parrafos. los separa por medio de comas
		push(@oraciones,split(/\,+/, $parrafos[$var])); 
		
		$numOraciones=scalar(@oraciones);
		for (my $var = 0; $var < $numOraciones; $var++) {
			
			buscaNombre($oraciones[$var]);
			buscarEstadoCivil($oraciones[$var]);
			buscaEstatura($oraciones[$var]);
			buscaPeso($oraciones[$var]);
			
			if($oraciones[$var]=~/[Ii]ng\./){
				$oraciones[$var]="$oraciones[$var]"."$oraciones[$var+1]";
				
			}
			
			
		}
		print sal "\n\n";
		undef(@oraciones);
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

#Funcion que busca La universidad y la carrera en el dataset
sub buscarEstudios {
	$nom=$_[0];
	if ($nom =~ /([eE]studi[oeé] |estudiante )([A-Za-záéíóÁÉÍÓÚS|.\s]+)*/) {
		$estudios=$2;
		print sal $2."\n";
		if($estudios=~/([Ee][Ss][Pp][Oo][Ll]|Escuela)/){
			print sal "Universidad: ESPOL \n"
		}if($estudios=~/Ing ([A-Za-záéíóÁÉÍÓÚS\s]+)*/){
			print sal "Carrera:  $1 \n"
		}
		#	print sal "NO SE ENCONTRO \n";
		
	} 
}

#función que busca el estado civil
sub buscarEstadoCivil {
	
	$estadoCiv=$_[0];	if ($estadoCiv =~ /([Ss]oy |[Ee]stoy |[Mm]e encuentro )(solter[oa])/){
		print sal "Estado Civil: ".$2."\n";
	}
	if ($estadoCiv =~ /([Ss]oy |[Ee]stoy |[Mm]e encuentro )(casad[oa])/){
		print sal "Estado Civil: ".$2."\n";
	}
}

#funcion que busca la estatura sub buscaEstatura {
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
	}	}

#funcion que busca el pesosub buscaPeso{
	$peso=_[0];
	#Encuentra los pesos en kilogramos
	if ($peso =~ /([pP]eso |al rededor de |aproximadamente |mi peso es )([0-9]{2})+(kg| kg|kilogramos| kilogramos)*/){
		print sal "Peso: ".$2." kilogramos\n";
	}
	#Encuentra las estaturas en libras y las convierte a kilogramos
	if ($peso =~ /([pP]eso |al rededor de |aproximadamente |mi peso es )([0-9]{3})+(lb| lb|libras| libras)*/){
		$datopeso = $2*(0.45);
		print sal "Peso: ".$datopeso." kilogramos\n";
	}	
	}

#funcion que busca el 