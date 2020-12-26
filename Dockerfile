ARG ARCH_VERSION=base-20201220.0.11678

FROM archlinux:$ARCH_VERSION

RUN pacman -Sy && pacman -S --noconfirm \
    tigervnc xorg \
    wget bc sudo \
    xfce4 \
    vim

ENV DUMB_INIT_VERSION "1.2.4"

RUN wget -O /usr/local/bin/dumb-init \
"https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}"\
"/dumb-init_${DUMB_INIT_VERSION}_aarch64"

RUN chmod +x /usr/local/bin/dumb-init

RUN useradd -m -G wheel --create-home \
-p "$(openssl passwd -1 changeme)" docker

RUN mkdir -p /home/docker

RUN mkdir -p /home/docker/.vnc

RUN chown -R docker /home/docker

COPY ./sudoers-config /etc/sudoers.d/

COPY ./vnc-config/ /vnc_defaults/

COPY ./start.sh /entrypoint

RUN chmod +x /entrypoint

ENV DISPLAY :1
ENV EDITOR vim

USER docker

VOLUME /home/docker/.vnc

EXPOSE 5901
EXPOSE 5801

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD ["/entrypoint"]
