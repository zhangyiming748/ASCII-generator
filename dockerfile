FROM python:3.11.10-bookworm
ENV PYTHONWARNINGS="ignore:getsizedeprecated"
COPY sources.list /etc/apt/sources.list
RUN apt update
RUN apt install build-e* libgl1 libglib2.0-0 -y
COPY requirements.txt .
RUN pip install -r requirements.txt --break-system-packages
RUN pip install -r requirements.txt
RUN pip config set global.index-url https://mirrors4.tuna.tsinghua.edu.cn/pypi/web/simple
RUN sed -i 's/deb.debian.org/mirrors4.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's/security.debian.org/mirrors4.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list