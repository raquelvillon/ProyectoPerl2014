use utf8; #permite que se compilen caracteres especiales como las vocales tildadas y las eñes
open (datos,"<:encoding(UTF-8)","dataset.txt"); #hace que lea el txt tal y como esta escrito, incluidas los caracteres esperciales

@informacion=<datos>;
close (datos);
open (sal,">salida.txt");
foreach $inf(@informacion){
	
	if (length($inf)>20) {
		push(@parrafos,$inf);
	}
}
$numParrafos=length(@parrafos);
foreach $info(@parrafos){
	
	push(@oraciones,split(/\,+/, $info));
	
}
 
foreach $nom (@oraciones){
	
	if ($nom =~ /(nombre es |llamo )([A-Za-záéíóÁÉÍÓÚS\s]+)*/) {
		print sal "Nombre: ".$2."\n";
	}
	if ($nom =~ /([eE]studio en (\s|la ))([0-9a-zA-Z]+)*/) {
		#print "Universidad: $3 \n"
	}
		
	#print "\n";
}
	        

close (sal);



