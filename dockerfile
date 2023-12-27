from centos:7
#安装python环境
run  yum -y install wget openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel zlib-devel libffi-devel  gcc make
run  wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz
run tar -xvf Python-3.9.0.tgz
run mkdir -p /usr/local/python3
run cd Python-3.9.0 && ./configure --prefix=/usr/local/python3 && make && make install
run ln -s /usr/local/python3/bin/python3.9 /usr/bin/python3 && ln -s /usr/local/python3/bin/pip3.9 /usr/bin/pip3
# 安装vscode
# 指定变量
env password 123456
# 声明端口
EXPOSE 8080
run     wget https://github.com/coder/code-server/releases/download/v4.16.1/code-server-4.16.1-linux-amd64.tar.gz && tar -xvf code-server-4.16.1-linux-amd64.tar.gz
cmd export PASSWORD=$password && ./code-server-4.16.1-linux-amd64/bin/code-server  --host 0.0.0.0 --port 8080
