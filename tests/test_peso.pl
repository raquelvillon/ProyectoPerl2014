use utf8; #permite que se compilen caracteres especiales como las vocales tildadas y las eñes
open (datos,"<:encoding(UTF-8)","dataset.txt"); #hace que lea el txt tal y como esta escrito, incluidas los caracteres esperciales

@informacion=<datos>;
close (datos);
open (sal,">salidaPeso.txt");
foreach $inf(@informacion){
	
	if (length($inf)>20) {
		push(@parrafos,$inf);
	}
}
$numParrafos=length(@parrafos);

foreach $info(@parrafos){
	push(@oraciones,split(/\,+/, $info));
}
 
foreach $peso (@oraciones){
	#Encuentra los pesos en kilogramos
	if ($peso =~ /([pP]eso |[pP]eso aproximadamente |[pP]eso alrededor de |mi peso es )([0-9][0-9][0-9])+([lL]b| [lL]b|[lL]ibras| [lL]ibras)*/){
		$datopeso = $2*(0.45);
		print sal "Peso: ".$datopeso." kilogramos\n";
	}elsif ($peso =~ /([pP]eso |[pP]eso aproximadamente |[pP]eso alrededor de |mi peso es )([0-9][0-9])([kK]g| [kK]g|[kK]ilogramos| [kK]ilogramos)*/){
		#$datopeso = $2;
		print sal "Peso: ".$2." kilogramos\n";
	}
		
	#print "\n";
}     

close (sal);