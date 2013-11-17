use common::sense;

use PDL;
use PDL::Graphics::PLplot;


sub PI () { 3.14159265358979 }


mkdir('output/');


{
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg', PAGESIZE => [800,350], FILE => 'output/ask1.svg');
  my $x = sequence(1000)/100;

  my $signal = sin($x);
  my $carrier = sin(50 * $x);
  my $am = (0.5 * $signal + 0.5) * $carrier;

  $pl->stripplots($x, [ $am, $carrier, $signal, ],
                      YLAB => [ 'AM', 'Carrier', 'Signal', ],
                      COLOR => [qw/BLUE RED BLACK/]);

  $pl->close();
}



{
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg', PAGESIZE => [800,350], FILE => 'output/ask2.svg');
  my $x = sequence(1000)/100;

  my $signal1 = sin(15 * $x);
  my $signal2 = sin(15 * $x * 1.1);
  my $sum = $signal1 + $signal2;

  $pl->stripplots($x, [ $sum, $signal2, $signal1, ],
                      YLAB => [ 'AM', 'Sideband 2', 'Sideband 1', ],
                      COLOR => [qw/BLUE RED BLACK/]);

  $pl->close();
}


{
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg', PAGESIZE => [800,350], FILE => 'output/ask2-1.svg');
  my $x = sequence(1000)/100;

  my $signal1 = sin(10 * $x);
  my $signal2 = sin(10 * $x * 1.1);
  my $sum = $signal1 + $signal2;

  $pl->xyplot($x, $signal1->cat($signal2)->cat($sum), COLOR => 'RED', BOX => [$x->minmax, $sum->minmax]);
  $pl->xyplot($x, $signal2, COLOR => 'BLUE');
  $pl->xyplot($x, $sum, COLOR => 'BLACK');

  $pl->close();
}


{
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg', PAGESIZE => [800,350], FILE => 'output/ask2-2.svg');
  my $x = sequence(1000)/100;

  my $signal = 0.5 * sin($x) + 0.5;
  my $carrier = sin(50 * $x);
  my $am = $signal * $carrier;

  $pl->xyplot($x, $am, COLOR => 'BLACK');
  $pl->xyplot($x, $signal, COLOR => 'RED');

  $pl->close();
}




{
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg', PAGESIZE => [800,350], FILE => 'output/ask3.svg');
  my $x = sequence(1000)/100;

  my $signal = sin($x) < 0;
  my $carrier = sin(50 * $x);
  my $am = $signal * $carrier;

  $pl->stripplots($x, [ $am, $carrier, $signal, ],
                      YLAB => [ 'AM', 'Carrier', 'Square-Wave Signal', ],
                      COLOR => [qw/BLUE RED BLACK/]);

  $pl->close();
}



{
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg', PAGESIZE => [800,350], FILE => 'output/square-wave.svg');
  my $x = sequence(1000)/100;

  my $fund = sin(5 * $x);
  my $h3 = sin(5 * $x * 3) / 3;
  my $h5 = sin(5 * $x * 5) / 5;
  my $sum = $fund + $h3 + $h5;

  $pl->stripplots($x, [ $sum, $h5, $h3, $fund ],
                      YLAB => [ 'Square', '5th', '3rd', 'Fund', ],
                      COLOR => [qw/BLUE GREEN RED BLACK/]);

  $pl->close();
}



{
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg', PAGESIZE => [800,350], FILE => 'output/shaping1.svg');
  my $x = sequence(1000)/100;

  my $signal = 0.5 * sin(($x + 10)/2) + 0.5;
  my $carrier = sin(50 * $x);

  my $signal2 = $signal->slice('0:518')->append(ones(481));

  my $am = $signal2 * $carrier;

  $pl->xyplot($x, $am, COLOR => 'BLACK');
  $pl->xyplot($x, $signal2, COLOR => 'RED');

  $pl->close();
}



{
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg', PAGESIZE => [800,350], FILE => 'output/shaping2.svg');
  my $x = sequence(1000)/100;

  my $signal = 0.5 * sin(5 * ($x + 10)/2) + 0.5;
  my $carrier = sin(50 * $x);

  my $signal2 = $signal->slice('0:590')->append(ones(409));

  my $am = $signal2 * $carrier;
  $am = zeros(440)->append($am->slice('440:'));

  $pl->xyplot($x, $am, COLOR => 'BLACK');
  $pl->xyplot($x, $signal, COLOR => 'RED');

  $pl->close();
}
