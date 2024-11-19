FROM python:3.6-bullseye
# docker run -dit --name ascll -v C:\Users\zen\Github\ASCII-generator:/data python:3.6-bullseye bash
# docker exec -it ascll bash
COPY sources.list /etc/apt/sources.list
# RUN sed -i 's/deb.debian.org/mirrors4.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
# RUN sed -i 's/security.debian.org/mirrors4.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN rm /etc/apt/sources.list
RUN apt update
RUN apt install build-e* -y
RUN pip install numpy pillow opencv-python
RUN pip config set global.index-url https://mirrors4.tuna.tsinghua.edu.cn/pypi/web/simple
RUN sed -i 's/deb.debian.org/mirrors4.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/debian.sources
RUN sed -i 's/security.debian.org/mirrors4.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/debian.sources