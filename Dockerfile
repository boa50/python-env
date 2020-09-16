FROM tensorflow/tensorflow:latest-gpu-jupyter
LABEL maintainer="https://github.com/boa50"

RUN apt-get update
RUN apt-get install -y xvfb python-opengl ffmpeg

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Criacao de usuario nao root
ARG USERNAME=boa50
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

EXPOSE 8888

CMD ["bash","-c","source /etc/bash.bashrc && jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root"]
