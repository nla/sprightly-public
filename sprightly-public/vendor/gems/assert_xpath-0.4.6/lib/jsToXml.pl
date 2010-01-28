  use strict;
  use Javascript::PurePerl;  
  open(JS, $ARGV[0]);
  read(JS, my $source, -s JS);
  close(JS);
  my $tree = Javascript::PurePerl->new()->parse( code => $source );
  
  print $tree->toString,"\n";

