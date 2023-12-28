FROM python:3.10
run apt-get update
RUN  export DEBIAN_FRONTEND=noninteractive  && apt-get -qq update  && apt-get -qq install ffmpeg git    
run curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
run  export DEBIAN_FRONTEND=noninteractive && apt-get -qq install git-lfs
run git clone https://huggingface.co/openai/whisper-large-v2
run ls
