FROM python:3.10-slim
RUN  export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install ffmpeg
