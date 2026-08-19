FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# 1. 安装基础依赖、添加 deadsnakes PPA 并安装 Python 3.11 及其开发包
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    ca-certificates \
    curl \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y --no-install-recommends \
    python3.11 \
    python3.11-dev \
    python3.11-venv \
    python3.11-distutils \
    build-essential \
    cmake \
    git \
    libgomp1 \
    libxml2-dev \
    zlib1g-dev \
    libopenblas-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. 软链接将 python 和 python3 指向 python3.11
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1

# 3. 安装针对 Python 3.11 的 pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 \
    && python -m pip install --upgrade pip setuptools wheel

WORKDIR /workspace

# 4. 安装 PyTorch (CUDA 12.8)
RUN pip install torch==2.11.0+cu128 \
    --extra-index-url https://download.pytorch.org/whl/cu128

# 5. 安装 PaddlePaddle-GPU
RUN pip install paddlepaddle-gpu==2.6.2

# 6. 安装 paddlenlp
RUN pip install paddlenlp==2.6.1 --no-deps

# 7. 安装其他依赖
COPY requirements.txt .
RUN pip install --ignore-installed -r requirements.txt

CMD ["/bin/bash"]
