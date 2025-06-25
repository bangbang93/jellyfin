FROM bitnami/git AS git

WORKDIR /rffmpeg
RUN git clone https://github.com/joshuaboniface/rffmpeg --depth 1 .

FROM jellyfin/jellyfin

RUN apt-get update && apt-get install -y fonts-noto-cjk fonts-noto-cjk-extra python3-yaml python3-click openssh-client && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

COPY --from=git /rffmpeg/rffmpeg /usr/local/bin/rffmpeg
COPY --from=git /rffmpeg/rffmpeg.yml.sample /etc/rffmpeg/rffmpeg.yml.sample
RUN chmod +x /usr/local/bin/rffmpeg && \
  ln -s /usr/local/bin/rffmpeg /usr/local/bin/ffmpeg && \
  ln -s /usr/local/bin/rffmpeg /usr/local/bin/ffprobe && \
  ln -s /config/rffmpeg.yml /etc/rffmpeg/rffmpeg.yml
