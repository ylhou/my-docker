# 基础镜像：CUDA 12.8 + Ubuntu 22.04
FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# 安装 Python 3.10 及编译 C++ 扩展所需的构建依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    cmake \
    git \
    libgomp1 \
    ca-certificates \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# 升级 pip & 基础打包工具
RUN python -m pip install --upgrade pip setuptools wheel

# 1. 单独安装 PyTorch GPU 版本 (CUDA 12.8)
RUN pip install torch==2.11.0+cu128 \
    --extra-index-url https://download.pytorch.org/whl/cu128

# 2. 单独安装 PaddlePaddle-GPU (2.6.2)
RUN pip install paddlepaddle-gpu==2.6.2 \
    -i https://pypi.tuna.tsinghua.edu.cn/simple

# 3. 安装 paddlenlp 及其他 Python 依赖
COPY requirements.txt .
RUN pip install paddlenlp==2.6.1 -r requirements.txt

CMD ["/bin/bash"]
