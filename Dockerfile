FROM tensorflow/tensorflow:latest-gpu-jupyter
LABEL maintainer="https://github.com/boa50"

RUN apt-get update
RUN apt-get install -y xvfb python-opengl ffmpeg

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8888

CMD ["bash","-c","source /etc/bash.bashrc && jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root"]
