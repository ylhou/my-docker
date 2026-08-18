FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# 1. 补齐编译 C++ / igraph / lightgbm 所需的底层库
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
    && ln -s /usr/bin/python3 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# 升级 pip，启用更快的构建工具
RUN python -m pip install --upgrade pip setuptools wheel

# 2. 安装 PyTorch (CUDA 12.8)
RUN pip install torch==2.11.0+cu128 \
    --extra-index-url https://download.pytorch.org/whl/cu128

# 3. 安装 PaddlePaddle-GPU
RUN pip install paddlepaddle-gpu==2.6.2 \
    -i https://pypi.tuna.tsinghua.edu.cn/simple

# 4. 单独安装 paddlenlp（使用国内镜像并忽略部分过严的强依赖约束）
RUN pip install paddlenlp==2.6.1 --no-deps \
    -i https://pypi.tuna.tsinghua.edu.cn/simple

# 5. 安装剩余 requirements 依赖
COPY requirements.txt .
RUN pip install -r requirements.txt \
    -i https://pypi.tuna.tsinghua.edu.cn/simple
