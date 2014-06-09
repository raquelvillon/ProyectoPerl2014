use utf8; #permite que se compilen caracteres especiales como las vocales tildadas y las eñes
open (datos,"<:encoding(UTF-8)","dataset.txt"); #hace que lea el txt tal y como esta escrito, incluidas los caracteres esperciales

@informacion=<datos>;
close (datos);
open (sal,">salidaEmail.txt");
foreach $inf(@informacion){
	
	if (length($inf)>20) {
		push(@parrafos,$inf);
	}
 
	#Encuentra mails
	if ($inf =~ /(([a-z0-9!#&'*+=?^_`{|}~-])+)*+@(([a-z]+\.)+([a-z]{2,6}|com|org|net|edu|gov|mil|biz|info|name|aero|asia|jobs|museum))/){
		print sal "e-mail: ".$1."@".$3."\n";
	}
	
	#print "\n";
}     

close (sal);