use utf8; #permite que se compilen caracteres especiales como las vocales tildadas y las eñes
# load module
use DBI;

# connect
my $dbh = DBI->connect("DBI:Pg:dbname=postgres;host=localhost", "postgres", "postgres", {'RaiseError' => 1});

open (datos,"<:encoding(UTF-8)","dataset.txt"); #hace que lea el txt tal y como esta escrito, incluidas los caracteres esperciales
	@informacion=<datos>; #guarda cada linea dentro del arreglo "@informacion"
close (datos);


#todos los resultados se imprimirán aquí 
open (sal,">salida.txt");

$dbh->do("drop table estudiantes");
$dbh->do("CREATE TABLE estudiantes (id INTEGER, nombre VARCHAR(50), edad VARCHAR(20), estatura VARCHAR(20), peso VARCHAR(20), correo VARCHAR(50), lugarnacimiento VARCHAR(15), estadocivil VARCHAR(20), telefono VARCHAR(15),  universidad VARCHAR(50), carrera VARCHAR(100));");
$i=0;
	#guarda solo las lineas que tienen texto, se salta las lineas en blanco
	foreach $inf(@informacion){
		
		if (length($inf)>2) {
			push(@parrafos,$inf);
			$i=$i+1;
			#funciones para buscar información
			
			$name=buscaNombre($inf);
			$age=buscaEdad($inf);
			($university,$carreer)=buscarEstudios($inf);
			$email=buscarMail($inf);
			$height=buscarEstatura($inf);
			$weight=buscarPeso($inf);
			$phone=buscarTelefono($inf);
			$status=buscarEstadoCivil($inf);
			$city=buscarCiudadNatal($inf);
			my $rows = $dbh->do("INSERT INTO estudiantes (id,nombre,edad,estatura,peso,correo,lugarnacimiento,estadocivil,telefono,universidad,carrera) VALUES ($i,'$name','$age','$height','$weight','$email','$city','$status','$phone','$university','$carreer')");
			print sal "\n\n";
	}
	}
close (sal);
$dbh->disconnect();

#Funcion que busca los nombres en el dataset
sub buscaNombre {
	$nom=$_[0];
	$datoNom=" ";
	if ($nom =~ /(nombre es |llamo )([A-Za-záéíóÁÉÍÓÚ\s]+)*/) {
		$nombre=$2;
		if($nombre=~/([A-Za-záéíóúÁÉÍÓÚS\s]+)*(tengo|nac[íi])/){
		print sal "Nombre: ".$1."\n";
		$datoNom=$1;
		}else{
			print sal "Nombre: ".$nombre."\n";
			$datoNom=$nombre;
		}
		
	}
	return($datoNom);
}

#Funcion que busca las edades en el dataset
sub buscaEdad {
	$nom=$_[0];
	$datoEdad=" ";
	if ($nom =~ /[tT]engo ([0-9\s]+)* [aA]ños/) {
		print sal "Edad: ".$1."\n";
		$datoEdad=$1;
	}
	return($datoEdad);
}

#Funcion que busca La universidad y la carrera en el dataset  
sub buscarEstudios {
	$nom=$_[0];
	$datoUniversidad=" ";
	$datoCarrera=" ";
	if ($nom =~ /([eE]studi[oeé] |estudiante )([A-Za-záéíóÁÉÍÓÚS,.\s]+)*/) {
		$estudios=$2;
		#print sal $2."\n";
		
		if($estudios=~/([Ii]ngenier[íi]a|Ing\.)([A-Za-záéíóÁÉÍÓÚS\s]+)*/){
			$carrera=$2;
			if($carrera=~/([A-Za-záéíóÁÉÍÓÚS\s]+)*(en ESPOL|en la Escuela|en la ESPOL)/){
				print sal "Carrera: Ingeniería$1 \n";
				$datoCarrera="Ingeniería".$1;
			}else{
				print sal "Carrera: Ingeniería$carrera \n";
				$datoCarrera="Ingeniería".$carrera;
			}
			
			
		}elsif(/(carrera (es|de estudio|de))([A-Za-záéíóÁÉÍÓÚS\s]+)*/){
			$carrera=$2;
			if($carrera=~/([A-Za-záéíóÁÉÍÓÚS\s]+)*(en ESPOL|en la Escuela|en la ESPOL)/){
				print sal "Carrera: Ingeniería".$1." \n";
				$datoCarrera="Ingeniería".$1;
			}else{
				print sal "Carrera: $carrera \n";
				$datoCarrera="Ingeniería".$carrera;
			}
		}elsif($estudios=~/[Ll]eyes/){
			print sal "Carrera:  Leyes \n";
			$datoUniversidad="Leyes";
		}
		if($estudios=~/([Ee][Ss][Pp][Oo][Ll]|Escuela)/){
			print sal "Universidad: ESPOL \n";
			$datoUniversidad="ESPOL";
		}elsif($estudios=~/([Cc][Aa][Tt][Oo][Ll][Ii][Cc][Aa]|[Uu][Cc][Ss][Gg])/){
			print sal "Universidad: Católica \n";
			$datoUniversidad="Católica";
		}elsif($estudios=~/([Ee]statal|[Uu]niversidad de [Gg]uayaquil)/){
			print sal "Universidad: Estatal \n";
			$datoUniversidad="Estatal";
		}

		
	}
	return($datoUniversidad,$datoCarrera);
}


#Funcion que busca direcciones de correo electronico en el dataset 
sub buscarMail {
	$mail=$_[0];
	$datoMail=" ";
	if ($mail =~ /(([a-z0-9!#&'*+=?^_`{|}~-])+)*+@(([a-z]+\.)+([a-z]{2,6}|com|org|net|edu|gov|mil|biz|info|name|aero|asia|jobs|museum))/){
		print sal "E-mail: ".$1."@".$3."\n";
		$datoMail=$1."@".$3;
	}
	return($datoMail);
}

sub buscarPeso {
	$peso=$_[0];
	$datoPeso=" ";	if ($peso =~ /([pP]eso |[pP]eso aproximadamente |[pP]eso alrededor de |mi peso es )([0-9][0-9][0-9])+([lL]b| [lL]b|[lL]ibras| [lL]ibras)*/){
		$datopeso = $2*(0.45);
		print sal "Peso: ".$datopeso." kilogramos\n";
		$datoPeso=$datopeso." kilogramos";
	}elsif ($peso =~ /([pP]eso |[pP]eso aproximadamente |[pP]eso alrededor de |mi peso es )([0-9][0-9])([kK]g| [kK]g|[kK]ilogramos| [kK]ilogramos)*/){
		print sal "Peso: ".$2." kilogramos\n";
		$datoPeso=$2." kilogramos";
	}
	return($datoPeso);
}

sub buscarTelefono{
	$telf=$_[0];
	$datoTelf=" ";
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
	}
	return($datoTelf);
		}

sub buscarEstadoCivil{
	$estadoCiv=$_[0];
	$datoEstadoCiv=" ";
	#Encuentra los estados civil
	if ($estadoCiv =~ /([Ss]oy |[Ee]stoy |[Mm]e encuentro )(solter[oa])/){
		print sal "Estado Civil: ".$2."\n";
		$datoEstadoCiv=$2;
	}
	if ($estadoCiv =~ /([Ss]oy |[Ee]stoy |[Mm]e encuentro )(casad[oa])/){
		print sal "Estado Civil: ".$2."\n";
		$datoEstadoCiv=$2;
	}
	return($datoEstadoCiv);	}sub buscarEstatura {
	$estatura=$_[0];
	$datoEstatura=" ";
	#Encuentra las estaturas en metros
	if ($estatura =~ /([mM]ido |[mM]i estatura es de |[mM]i estatura es |[mM]ido aproximadamente )([1]+\.)+([0-9]{2}|[0-9])+(m| m|metros| metros)*/){
		$datoestatura = $2.$3;
		if (length($datoestatura)<4){
			$datoestatura = $datoestatura."0";
		}
		print sal "Estatura: ".$datoestatura." metros\n";
		$datoEstatura=$datoestatura." metros";
		#print sal "Estatura: ".$2.$3." metros\n";
	}
	#Encuentra las estaturas en centimetros
	if ($estatura =~ /([mM]ido |[mM]i estatura es de |[mM]i estatura es |[mM]ido aproximadamente )([0-9]{3})+(cm| cm|centimetros| centimetros)*/){
		$datoestatura = $2/100;
		print sal "Estatura: ".$datoestatura." metros\n";
		$datoEstatura=$datoestatura." metros";
	}
	return($datoEstatura);}
sub buscarCiudadNatal {
	$nom=$_[0];
	$datoCiudadNatal=" ";
	if ($nom =~ /(nac[íi] (en|el|)|mi ciudad natal|lugar de nacimiento es (en|))([0-9A-Za-záéíóÁÉÍÓÚñ\.\s]+)*/) {
		$nombre=$4;
		
		if($nombre=~/[Gg]uayaquil/){
			print sal "Ciudad de Nacimiento: Guayaquil \n";
			$datoCiudadNatal="Guayaquil";
		}elsif ($nombre=~/[Bb]abahoyo/){
			print sal "Ciudad de Nacimiento: Babahoyo \n";
			$datoCiudadNatal="Babahoyo";
		}elsif ($nombre=~/[Ll]oja/){
			print sal "Ciudad de Nacimiento: Loja \n";
			$datoCiudadNatal="Loja";
		}elsif ($nombre=~/[Qq]uito/){
			print sal "Ciudad de Nacimiento: Quito \n";
			$datoCiudadNatal="Quito";
		}elsif ($nombre=~/[Cc]uenca/){
			print sal "Ciudad de Nacimiento: Cuenca \n";
			$datoCiudadNatal="Cuenca";
		}
		
	}
	return($datoCiudadNatal);
}

