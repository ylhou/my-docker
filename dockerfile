FROM python:3.10-slim
RUN  export DEBIAN_FRONTEND=noninteractive && apt-get -qq update && apt-get -qq install ffmpeg
run mkdir my-docker
copy *  my-docker
run cd my-docker && ls
#run pip install -U openai-whisper
#run whisper test.mp3  --model medium
