FROM ghcr.io/linuxserver/baseimage-selkies:debiantrixie

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CALLIGRA_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# title
ENV TITLE=Calligra

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /usr/share/selkies/www/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/calligra-logo.png && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install --no-install-recommends -y \
    breeze-icon-theme \
    caja \
    calligra \
    calligra-data \
    calligraplan \
    calligrastage \
    kexi \
    stterm \
    tint2 && \
  echo "**** openbox tweaks ****" && \
  sed -i \
    's/NLMC/NLIMC/g' \
    /etc/xdg/openbox/rc.xml && \
  sed -i \
    '/Icon=/c Icon=xterm-color_48x48' \
    /usr/share/applications/st.desktop && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
