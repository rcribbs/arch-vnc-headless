FROM archlinux/base

RUN pacman -Sy && pacman -S --noconfirm xfce4 tigervnc xorg
RUN pacman -Sy && pacman -S --noconfirm vim wget bc

RUN wget -O /usr/local/bin/dumb-init \
https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64

COPY ./vnc-config/ /root/.vnc/
COPY ./start.sh /entrypoint

RUN chmod +x /root/.vnc/xstartup
RUN chmod +x /entrypoint
RUN chmod +x /usr/local/bin/dumb-init

ENV DISPLAY :1

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD ["/entrypoint"]
