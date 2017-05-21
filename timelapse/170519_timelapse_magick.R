# Quick and dirty solution for Timelapse video
# zoom large images
# crop and scale
# 170519 - gopro
# samsung, ubuntu, magick

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


# kansio 130
kansio <- 130
kuvat <- c(24136:25112)

kansio <- 131
kuvat <- c(25113:26111)

kansio <- 132
kuvat <- c(26112:27110)

kansio <- 133
kuvat <- c(27111:28109)

kansio <- 134
kuvat <- c(28110:28961)

if (kansio == 130) {
  alkuzoomi = T
  ii = 100
} else {
  alkuzoomi = F
  ii = 0
}
path_i <- paste0('/home/jaakko/Documents/gopro/',kansio,'GOPRO/')
path_o <- '/home/jaakko/Documents/gopro/output/'
setwd(path_i)

videokoko <- 12800


iii = 0
for (i in kuvat) {
  iii = iii + 1
  talo <- image_read(paste0("G00",i,".JPG"))
  if (videokoko == 1280) {
    talo2 <- image_crop(talo, "1280x720+990+780")  
  } else {
    # DVD-videon resoluutio on korkeintaan 720×576 pikseliä (PAL)
    ii = ii - 1
    if (ii<0) {ii=0}
    skaala <- as.character(2400 - ii)
    talo2a <- image_scale(talo,skaala)
    
    talo2 <- image_crop(talo2a, "720x576+720+480")  
  }
  
  image_write(talo2, path = paste0(path_o,"talo",i,".jpg"), format = "jpg",quality=40)
  print(paste(iii,"/",length(kuvat),". img:",i))
  }
  
#   
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