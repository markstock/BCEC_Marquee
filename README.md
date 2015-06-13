# BCEC_Marquee
A Processing sketch and set of scripts to produce artwork for the Boston Convention Center's 7-screen marquee

### Prerequisites

This system was designed to work on Linux, where there are plenty of useful command-line tools to assist in the generation, manipulation, and assembly of images and videos. Contributions for other operating systems are welcome.

### Movie Creation

1. Add your own code to the `setup()` and `draw()` routines. Use the `useScreen` variable to change what's drawn to each screen.

2. Set the `useScreen` variable to the desired screen, `maxFrames` to the number of frames to render, and set `record` to `true`.

3. Run the program. It will generate the requested number of frames and write them to this directory.

4. Run the program with `record = true` for the other two screens.

5. For the following sequence of Perl scripts, you will need the `netpbm` package installed. Some of the scripts accept command-line arguments. The first two arguments are the indexes for first and last frames to be processed. The below examples are written for a 30-second, 899-frame sequence.

        ./assemble.pl 1 899

6. The next one takes a block from the lower right image and creates data for the pillar lights.

        ./makelights.pl 1 899

7. These last two will apply the fade in from black and the fade out to black, replacing the original frames. The arguments are the first and last frames to be changed.

        ./fadefromblack.pl 1 30
        ./fadetoblack.pl 849 899

8. Encode the movie. You'll need the `mencoder` and 

        mencoder "mf://frame_????.png" -mf w=1920:h=1080:type=png:fps=30 -o video_1080p30.mov -sws 9 -of lavf -lavfopts format=mov -nosub -vf softskip,harddup -nosound -ovc x264 -x264encopts bitrate=15000:vbv_maxrate=20000:vbv_bufsize=2000:nointerlaced:force_cfr:frameref=3:mixed_refs:bframes=1:b_adapt=2:weightp=1:direct_pred=auto:aq_mode=1:me=umh:me_range=16:subq=6:mbtree:psy_rd=0.8,0.2:chroma_me:trellis=1:nocabac:deblock:partitions=p8x8,b8x8,i8x8,i4x4:nofast_pskip:nodct_decimate:threads=auto:ssim:psnr:keyint=300:keyint_min=30:level_idc=30:global_header

9. Finally, upload the image to the server. You'll need Microsoft Silverlight to do that. You're right, that is backwards.

(c) 2015 Mark J. Stock
