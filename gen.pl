use common::sense;

use PDL;
use PDL::Graphics::PLplot;
use PDL::Complex;


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

  $pl->xyplot($x, $signal1->cat($signal2)->cat($sum), COLOR => 'BLACK', BOX => [$x->minmax, $sum->minmax]);
  $pl->xyplot($x, $signal2, COLOR => 'RED');
  $pl->xyplot($x, $sum, COLOR => 'BLUE');

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
                      YLAB => [ 'Sum', '5th', '3rd', 'Fund', ],
                      BOX => [0, 10, -1, 1],
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



{
## FIXME
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg', PAGESIZE => [800,350], FILE => 'output/differential.svg');
  my $x = sequence(1000)/100;

  #my $i = -sin($x) * cos(PI/11) + (0 * i);
  #my $q = 0 + (sin($x) * sin(PI/11) * i);

  #my $i = (sin($x) * 1)   +   (0 * i);
  #my $q = (0)   +   (cos($x) * 0 * i);

  my $i = (sin($x) * cos(PI * 0.1))   +   (0 * i);
  my $q = (0)   +   (cos($x) * sin(PI * 0.1) * i);

  my $sum = $i + $q;

  my $sum = sqrt(re($sum)**2 + im($sum)**2);

  $pl->xyplot($x, $sum, COLOR => 'BLUE', BOX => [0, 10, -1, 1]);
  $pl->xyplot($x, im($q), COLOR => 'RED');
  $pl->xyplot($x, re($i), COLOR => 'BLACK');

  #$pl->stripplots($x, [ $sum, im($q), re($i), ],
  #                    YLAB => [ 'Sum', 'Q', 'I', ],
  #                    COLOR => [qw/BLUE RED BLACK/]);

  $pl->close();
}




{
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg', PAGESIZE => [800,300], FILE => 'output/psk.svg');
  my $x = sequence(1000)/100;

  my $signal = sin($x->slice('0:479'))->append(sin($x->slice('480:999') + PI));

  $pl->xyplot($x, $signal, COLOR => 'BLACK');

  $pl->close();
}




{
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg',
                                      #BOX => [0.65, 1.0, ],
                                      PAGESIZE => [800,300],
                                      FILE => 'output/diode.svg');
  my $x = 0.8 + sequence(180)/1000;

  my $y = 2 * (10 ** -11) * (exp($x / (1.5 * .0258)) - 1);

  $pl->xyplot($x, $y->cat($x), COLOR => 'BLACK');

  $pl->close();
}







{
  my $pl = PDL::Graphics::PLplot->new(DEV => 'svg', PAGESIZE => [800,350], FILE => 'output/sinc.svg');
  my $x = (sequence(1000) - 500)/20;

  my $s1 = cos($x);
  my $s2 = sin($x) / $x;

  $pl->xyplot($x, $s1, COLOR => 'BLACK', MAJTICKSIZE=>0, MINTICKSIZE=>0, XBOX=>'', YBOX=>'');
  $pl->xyplot($x, zeroes(1000), COLOR => 'BLACK');
  $pl->xyplot($x, $s2, COLOR => 'RED', LINEWIDTH => 3);

  $pl->close();
}
