FROM python:3.10-slim
#RUN  export DEBIAN_FRONTEND=noninteractive && apt-get -qq update && apt-get -qq install ffmpeg
run   apt-get -qq update &&  apt-get -qq install git && git clone https://github.com/SnowWindDancing/my-docker.git
run ls
#run pip install -U openai-whisper
#run whisper test.mp3  --model medium
