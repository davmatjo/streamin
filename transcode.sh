# Template for transcoding video files. Edit according to your media tracks

ffmpeg -i movie.mkv -an -sn -c:0 libx264 -x264opts 'keyint=24:min-keyint=24:no-scenecut' -b:v 5300k -maxrate 5300k -bufsize 2650k -vf 'scale=-1:1080' movie.mp4
ffmpeg -i movie.mkv -map 0:1 -sn -vn -ac 2 -ab 192k movie-aud.mp4
ffmpeg -i movie.mkv -map 0:2 -an -vn movie-sub.vtt

mp4fragment movie.mp4 movie-f.mp4

mp4dash --mpd-name=manifest.mpd movie-f.mp4 movie-aud-f.mp4 "[+format=webvtt,+language=en]movie-sub.vtt"