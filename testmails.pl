# Leer un fichero de texto
my $correos = 'mails.txt';
open INFILE,"<:encoding(utf8)",$correos;
# La palabra clave ‘my’ indica que las siguientes variables están léxicamente embebidas en el bloque que las contienen.
my $email;

#Preferible es ‘while’ ya que ‘foreach’ es que el fichero es leído enteramente en memoria.
while ( $email = <INFILE>) {
    chomp($email); 
    if ($email =~ /([a-z0-9])+@(([a-z]+\.)+[a-z]{2}|com|org|net|edu|gov|mil|biz|info|name|aero|asia|jobs|museum)/)
	{
		print "Es email!\n";
		#print "Usuario: $1\n";
		#print "Dominio: $2\n";
	}
	else
	{
		print "No es email!\n";
	}
    # print $email . "\n";
} 
close INFILE;