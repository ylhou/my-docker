 FROM python:3.10-slim
RUN  export DEBIAN_FRONTEND=noninteractive && apt-get -qq update && apt-get -qq install ffmpeg git
run git clone https://github.com/SnowWindDancing/my-docker.git
#run mkdir my-docker
#copy *  my-docker
run pip install -U openai-whisper
run whisper my-docker/test.mp3  --model large-v3 --language Mandarin
