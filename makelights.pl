#!/usr/bin/perl -w
# script named render.pl
#

# if no command-line args, assume bounds and check them
$startframe = 0;
$endframe = 99999;
$skip = 1;
if ($ARGV[0]) {
   $startframe = $ARGV[0];
   if ($ARGV[1]) {
      $endframe = $ARGV[1];
      if ($ARGV[2]) {
         $skip = $ARGV[2];
      }
   }
}

# loop over all frames
for ($frameno=$startframe; $frameno<=$endframe; $frameno+=$skip) {

   $framename = sprintf "raw_%4.4d", ${frameno};
   $outname = sprintf "frame_%4.4d", ${frameno};
   $temp = sprintf "temp_%4.4d", ${frameno};

   if (-e "${framename}.png" && ! -e "${outname}.png") {

      print "\ncreating ${outname}.png from ${framename}.png\n" ;

      # create the master file
      $command = "pngtopnm ${framename}.png > ${temp}a.ppm";
      print "${command}\n"; system "$command";

      # crop out part of the input
      #$command = "pamcut 1102 388 120 20 ${temp}a.ppm";
      $command = "pamcut 966 450 444 74 ${temp}a.ppm";

      # scale it to 6x1
      $command = "${command} | pamscale -xsize=6 -ysize=1";

      # scale it back up
      $command = "${command} | pamscale -xsize=600 -ysize=100 > ${temp}b.ppm";
      print "${command}\n"; system "$command";

      # and paste it back into the original
      $command = "pnmpaste -replace ${temp}b.ppm 1320 980 ${temp}a.ppm | pnmtopng -force > ${outname}.png";
      print "${command}\n"; system "$command";

      # remove temporaries
      system "rm ${temp}*.ppm";
   }
}

exit;
