# 选择Python 3.11.10基于Debian Bookworm的官方镜像作为基础镜像
FROM python:3.11.10-bookworm

# 设置PYTHONWARNINGS环境变量，忽略特定的关于'getsize deprecated'的警告
# 不过更建议后续还是对代码中相关使用进行修改，避免潜在问题
ENV PYTHONWARNINGS="ignore:getsizedeprecated"

COPY sources.list /etc/apt/sources.list

RUN apt update

# 明确安装build-essential软件包，避免使用通配符带来的不确定性，可按需添加更多软件包
RUN apt install build-essential libgl1 libglib2.0-0 -y

# 将项目的requirements.txt文件拷贝到容器内当前目录下，方便后续安装依赖
COPY requirements.txt .

# 安装项目依赖包，移除错误的--break-system-packages参数，在容器内的Python环境正常安装
RUN pip install -r requirements.txt --break-system-packages

# 设置pip的全局索引网址为清华的PyPI镜像源，加快Python包的安装速度
RUN pip config set global.index-url https://mirrors4.tuna.tsinghua.edu.cn/pypi/web/simple

# 使用清华源替换默认的Debian软件源，提高后续apt安装软件包的速度和稳定性

RUN sed -i 's/deb.debian.org/mirrors4.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors4.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list