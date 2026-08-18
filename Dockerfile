FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    ca-certificates \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update && apt-get install -y --no-install-recommends \
    python3.11 \
    python3.11-dev \
    python3.11-distutils \
    build-essential \
    cmake \
    git \
    libgomp1 \
    curl \
    && curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 \
    && ln -sf /usr/bin/python3.11 /usr/bin/python3 \
    && ln -sf /usr/bin/python3.11 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN python -m pip install --upgrade pip setuptools wheel

RUN pip install torch==2.11.0+cu128 \
    --extra-index-url https://download.pytorch.org/whl/cu128

RUN pip install paddlepaddle-gpu==2.6.2
RUN pip install paddlenlp==2.6.1 --no-deps

COPY requirements.txt .
RUN pip install -r requirements.txt

CMD ["/bin/bash"]
