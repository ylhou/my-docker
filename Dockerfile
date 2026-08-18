FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    cmake \
    git \
    libgomp1 \
    libxml2-dev \
    zlib1g-dev \
    libopenblas-dev \
    ca-certificates \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN python -m pip install --upgrade pip setuptools wheel

# 1. 安装 PyTorch (CUDA 12.8)
RUN pip install torch==2.11.0+cu128 \
    --extra-index-url https://download.pytorch.org/whl/cu128

# 2. 安装 PaddlePaddle-GPU
RUN pip install paddlepaddle-gpu==2.6.2

# 3. 安装 paddlenlp
RUN pip install paddlenlp==2.6.1 --no-deps

# 4. 安装其他依赖（加上 --ignore-installed 防止系统旧包阻断安装）
COPY requirements.txt .
RUN pip install --ignore-installed -r requirements.txt

CMD ["/bin/bash"]
