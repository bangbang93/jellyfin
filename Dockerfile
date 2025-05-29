FROM jellyfin/jellyfin

RUN apt update && apt install -y fonts-noto-cjk fonts-noto-cjk-extra && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*
