FROM pingme998/brav
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install unzip supervisor websockify -y

COPY novnc.zip /novnc.zip
COPY . /system

RUN unzip -o /novnc.zip -d /usr/share
RUN rm /novnc.zip

RUN chmod +x /system/conf.d/websockify.sh
RUN chmod +x /system/supervisor.sh

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
