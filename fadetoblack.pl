#!/usr/bin/perl -w
#
# fadefromblack.pl replaces an image with a faded image!

# if no command-line args, assume bounds and check them
# start frame is totally unmodified
$startframe = 849;
# end frame is totally black
$endframe = 899;

$check = $ARGV[0] . '0';;
if ($check) {
   chop ($check);
   $startframe = $check;
   if ($ARGV[1]) {
      $endframe = $ARGV[1];
   }
}

if (-e "temp.png") { system "rm temp.png"; }

for ($frameno=$startframe+1; $frameno<=$endframe; $frameno++) {

   $framename = sprintf "frame_%4.4d.png", ${frameno};

   if (-e "${framename}") {

      print "\nfading ${framename}\n" ;

      $factor = ($endframe-$frameno)/($endframe-$startframe);
      #$factor = ($frameno-$startframe)/($endframe-$startframe);
      $factor = 0.5 - 0.5*cos($factor * 3.1415927);
      $command = "pngtopnm ${framename} | pamfunc -multiplier $factor | pnmtopng -force > temp.png";
      print "${command}\n"; system $command;

      $command = "mv temp.png ${framename}";
      print "${command}\n"; system $command;

   }
}

if (-e "temp.png") { system "rm temp.png"; }
