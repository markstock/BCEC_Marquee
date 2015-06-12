#!/usr/bin/perl -w
# script named render.pl
#

# if no command-line args, assume bounds and check them
$startframe = 1;
$endframe = 899;
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

   $outname = sprintf "raw_%4.4d", ${frameno};

   if (! -e "${outname}.png") {

      print "\ncreating ${outname}.png\n" ;

      # start with a black frame
      system "cp black_1920x1080.ppm ./${outname}a.ppm";

      # scale and drop each of 3 panels onto this image

      # top image need to be dithered horizontally!
      $framename = sprintf "top_%4.4d", ${frameno};
      system "pngtopnm ${framename}.png | pamscale -width=288 -height=1024 -filter=sinc | pamscale -width=864 -height=1024 -filter=sinc > ${outname}_1.ppm";
      system "pnmpaste -replace ${outname}_1.ppm 0 0 ${outname}a.ppm > ${outname}b.ppm";

      # the other two are the high-res screens
      $framename = sprintf "left_%4.4d", ${frameno};
      system "pngtopnm ${framename}.png > ${outname}_2.ppm";
      system "pnmpaste -replace ${outname}_2.ppm 864 0 ${outname}b.ppm > ${outname}a.ppm";

      $framename = sprintf "right_%4.4d", ${frameno};
      system "pngtopnm ${framename}.png > ${outname}_3.ppm";
      system "pnmpaste -replace ${outname}_3.ppm 864 264 ${outname}a.ppm > ${outname}b.ppm";

      # and convert it to its final format
      system "pnmtopng -force ${outname}b.ppm > ${outname}.png";
      system "rm ${outname}*.ppm";
   }
}

exit;
