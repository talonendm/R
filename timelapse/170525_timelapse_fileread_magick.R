

# linux: copied from file exploderer.
# /media/jaakko/NO NAME/DCIM/100MEDIA
# /media/jaakko/NO NAME/DCIM/101MEDIA
# /media/jaakko/NO NAME/DCIM/102MEDIA
# /media/jaakko/NO NAME/DCIM/103MEDIA
# /media/jaakko/NO NAME/DCIM/104MEDIA
# /media/jaakko/NO NAME/DCIM/105MEDIA

# ---------------------------------------
# read folder names:  
# Quick and dirty solution for Timelapse video
# zoom large images
# crop and scale
# 170519 - gopro
# samsung, ubuntu, magick
# ----------------------------------------




# install.packages("magick")
# https://cran.r-project.org/web/packages/magick/vignettes/intro.html
library(magick)


testeja <- F

if (testeja){

tiger <- image_read('http://jeroen.github.io/images/tiger.svg')
image_info(tiger)

# We use image_write to export an image in any format to a file on disk, or in memory if path = NULL.
getwd()
# Render svg to png bitmap
setwd('/home/jaakko/magickoutput')
image_write(tiger, path = "tiger.png", format = "png")

# Example image
frink <- image_read("https://jeroen.github.io/images/frink.png")
print(frink)
frink2 <- image_crop(frink, "100x100+100+50")
print(frink2)

setwd('/home/jaakko/Documents/gopro/130GOPRO')

talo <- image_read("G0024118.JPG")

talo_old <- image_read("G0025108.JPG")


print(image_scale(talo,'300'))
# talo2 <- image_crop(talo, "1600x1200+940+350")
talo2 <- image_crop(talo, "1280x720+990+780")
talo3 <- image_crop(talo_old, "1280x720+990+780")

print(image_scale(talo2,'500'))

setwd('/home/jaakko/magickoutput')
image_write(talo2, path = "talo.jpg", format = "jpg")
# image_write(talo2, path = "talo.png", format = "png") - vie paljon tilaa...

image_write(talo2, path = "taloQ50.jpg", format = "jpg",quality=50)

# prosessoikuvat - animoi esim. crop zoomaus taloon.
# kuvat videoksi.. ffmpeg

# rename r puolella.. tallennus kaikki samaan kansioon



# vois vaan prosessoida kuvat ja sitten tehdä ffmeg : llä komentorivillä videon

# testi 
# Morphing creates a sequence of n images that gradually morph one image into another. It makes animations

# newlogo <- image_scale(image_read("https://www.r-project.org/logo/Rlogo.png"), "x150")
# oldlogo <- image_scale(image_read("https://developer.r-project.org/Logo/Rlogo-3.png"), "x150")

newlogo <- talo2
oldlogo <- talo3


rm(list = ls())

# cropatut reunat tyhjänä, tallenna kuvat ja sitten avaa uudestaan... jos tarvis 170515

# Toimii varmasti paremmin - jos vaikka piirretty editoitu kuva
frames <- image_morph(c(oldlogo, newlogo), frames = 3)
image_animate(frames)
getwd()
setwd('/home/jaakko/magickoutput')
image_write(frames, path = "taloframes.gif", format = "gif",quality=50)

}


# https://stat.ethz.ch/R-manual/R-devel/library/base/html/connections.html
# nextTime more sophisticated:
  ## Unix examples of use of pipes
  
  # read listing of current directory
readLines(pipe("ls -1"))




kameranimi <- 'riistakamera' # 'gopro'

ii <- 0

path_folders_i <- paste0('/home/jaakko/Documents/',kameranimi,'/')
allfolders <- list.dirs(path_folders_i)
inputfolders <- allfolders[grep('MEDIA',  list.dirs(path_folders_i))]
path_o <- allfolders[grep('output',  list.dirs(path_folders_i))]

# path_i <- paste0('/home/jaakko/Documents/gopro/',kansio,'GOPRO/')
# path_o <- paste0(path_folders_i,'output/')
# path_o <- grep('output',  list.dirs(path_folders_i))

path_i <- inputfolders[1]                 
                 
                 
setwd(path_i)

kuvat <- list.files(path_i)

kuvat[1]

test5pics <- F

if (test5pics) {
   i <- 130
   talo <- image_read(kuvat[i])
   image_info(talo)
   talo2 <- image_scale(talo,'200')
   image_info(talo2)
   # talo2 <- image_crop(talo, "1600x1200+940+350")
   talo2 <- image_crop(talo, "1280x720+490+380")
   image_info(talo2)
   print(image_scale(talo2,'300')) # to fit to preview window
   
   talo2 <- image_crop(talo, "720x576+490+380")
   talo2 <- image_scale(talo,"1280")
   image_info(talo2)
   print(image_scale(talo2,'300')) # to fit to preview window
   
   
    kuvat <- kuvat[1:5]
}


videokoko <- 12800


iii = 0

for (i_p in inputfolders) {
  
  setwd(i_p)
  print(i_p)
  
  kuvat <- list.files(path_i)
  if (test5pics) {
    kuvat <- kuvat[1:5]
  }
  iiii <- 0  

for (i in kuvat) {
  iii = iii + 1
  iiii = iiii + 1
  talo <- image_read(i)
  if (videokoko == 1280) {
    talo2 <- image_crop(talo, "1280x720+990+780")  
  } else {
    # DVD-videon resoluutio on korkeintaan 720×576 pikseliä (PAL)
    # ii = ii - 1
    # if (ii<0) {ii=0}
    # skaala <- as.character(2400 - ii)
    # talo2a <- image_scale(talo,skaala)
    # 
    # talo2 <- image_crop(talo2a, "720x576+720+480")
    
    talo2 <- image_scale(talo,"1280")
    
  }
  
  image_write(talo2, path = paste0(path_o,"//talo",iii,".jpg"), format = "jpg",quality=40)
  print(paste0(iiii," / ",length(kuvat),". Total images:",iii,". img:",i,", ",i_p))
  }
}
#   Git: talonendm, .1+......
# git 170525
# git add .
# git commit -am "R code for timelapse v2, create video on command line with FFmpeg"
# git push origin master
#   setwd('/home/jaakko/Documents/gopro/130GOPRO')
# 
# 
# 
# talo_old <- image_read("G0025108.JPG")
# 
# 
# print(image_scale(talo,'300'))
# # talo2 <- image_crop(talo, "1600x1200+940+350")
# 
# The program 'ffmpeg' is currently not installed. You can install it by typing:
# sudo apt install ffmpeg
# ffmpeg -start_number 24136 -i talo%d.jpg -vcodec mpeg4 test.avi

# toimii
# https://superuser.com/questions/624567/ffmpeg-create-a-video-from-images#12160155

# https://www.tecmint.com/ffmpeg-commands-for-video-audio-and-image-conversion-in-linux/
# Esim: anysointi tai sitten suoraan Rssa:
# 2. Split a video into images
# # To turn a video to number of images, run the command below. The command generates the files named image1.jpg, image2.jpg and so on…
# 12. Increase/Reduce Video Playback Speed
# 
# To increase video play back speed, run this command. The -vf option sets the video filters that helps to adjust the speed.
# 
# $ ffmpeg -i video.mpg -vf "setpts=0.5*PTS" highspeed.mpg
# 
# srt - tektit kans tuolla sivulla..