# load module
use DBI;

# connect
my $dbh = DBI->connect("DBI:Pg:dbname=postgres;host=localhost", "postgres", "postgres", {'RaiseError' => 1});

# execute INSERT query
$nomAnimal="muneca";
$raza="perro";
my $rows = $dbh->do("INSERT INTO pets (species, name) VALUES ('$raza', '$nomAnimal')");
print "$rows row(s) affected\n";

# execute SELECT query
my $sth = $dbh->prepare("SELECT species, name FROM pets");
$sth->execute();

# iterate through resultset
# print values
while(my $ref = $sth->fetchrow_hashref()) {
    print "$ref->{'name'} is a $ref->{'species'}\n";
}

# clean up
$dbh->disconnect();