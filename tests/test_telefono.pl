use utf8; #permite que se compilen caracteres especiales como las vocales tildadas y las eñes
open (datos,"<:encoding(UTF-8)","dataset.txt"); #hace que lea el txt tal y como esta escrito, incluidas los caracteres esperciales

@informacion=<datos>;
close (datos);
open (sal,">salidaTelefono.txt");
foreach $inf(@informacion){
	
	if (length($inf)>20) {
		push(@parrafos,$inf);
	}
}
$numParrafos=length(@parrafos);

foreach $info(@parrafos){
	push(@oraciones,split(/\,+/, $info));
}
 
foreach $telf (@oraciones){
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
	
	#print "\n";
}     

close (sal);