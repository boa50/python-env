FROM nvidia/cudagl:10.1-devel
LABEL maintainer="https://github.com/boa50"

RUN export DEBIAN_FRONTEND=noninteractive

RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64

RUN apt-get update

RUN apt install -y --no-install-recommends \
    libcudnn7=7.6.4.38-1+cuda10.1  \
    libcudnn7-dev=7.6.4.38-1+cuda10.1

RUN apt install -y --no-install-recommends libnvinfer6=6.0.1-1+cuda10.1 \
    libnvinfer-dev=6.0.1-1+cuda10.1 \
    libnvinfer-plugin6=6.0.1-1+cuda10.1

RUN apt-get install -y sudo xvfb python-opengl ffmpeg sudo mesa-utils python-opengl

RUN apt install -y --no-install-recommends python3-pip python3 python

RUN pip3 install --upgrade pip setuptools && pip install --upgrade pip

ENV PYTHONDONTWRITEBYTECODE 1

ENV PYTHONUNBUFFERED 1

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Criacao de usuario nao root
ARG USERNAME=boa50
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y python3-tk \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

EXPOSE 8888

CMD ["bash","-c","source /etc/bash.bashrc && jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root"]
