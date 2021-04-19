#!/bin/bash
cd b_opt_subs

#rm -rf *.mp4

ffmpeg -framerate 5 -pattern_type glob -i '*.png' -vf scale=-1:800 -c:v libx264 -crf 1 -pix_fmt yuv420p tmp.mp4

#ffmpeg -i tmp.mp4 -vf reverse -c:v libx264 -crf 1 -pix_fmt yuv420p dataCH_mov.mp4

#rm -f tmp.mp4

