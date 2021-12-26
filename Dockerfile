FROM ubuntu:20.04

LABEL Maintainer "Apoorv Vyavahare <apoorvvyavahare@pm.me>"

ARG DEBIAN_FRONTEND=noninteractive

#VNC Server Password
ENV VNC_PASS="samplepass" \
#VNC Server Title(w/o spaces)
    VNC_TITLE="Vubuntu_Desktop" \
#VNC Resolution(720p is preferable)
    VNC_RESOLUTION="1280x720" \
#VNC Shared Mode (0=off, 1=on)
    VNC_SHARED=0 \
#Local Display Server Port
    DISPLAY=:0 \
#NoVNC Port
    NOVNC_PORT=$PORT \
#Ngrok Token
    NGROK_AUTH_TOKEN="placeholder" \
#Brave Shared Memory Usage (Set it to 0 to disable the use of /dev/shm for Brave Browser, helpful for Heroku)
    BRAVE_USE_SHM=1 \
#Locale
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ="Asia/Kolkata"

COPY . /app/.vubuntu

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get --no-install-recommends install -y \
#Basic Packages
    tzdata software-properties-common apt-transport-https wget zip unzip htop git curl vim nano zip sudo net-tools x11-utils eterm iputils-ping build-essential xvfb x11vnc supervisor \
#GUI Utilities
    gnome-terminal gnome-calculator gnome-system-monitor pcmanfm terminator firefox \
    nodejs npm \
#Other Languages
    #perl \
    #ruby \
    #lua5.3 \
    #scala \
    #mono-complete \
    #r-base \
    #clojure \
    ffmpeg && \
#Fluxbox & noVNC
    apt-get install --no-install-recommends -y /app/.vubuntu/assets/packages/fluxbox.deb /app/.vubuntu/assets/packages/novnc.deb && \
    cp /usr/share/novnc/vnc.html /usr/share/novnc/index.html && \
    openssl req -new -newkey rsa:4096 -days 36500 -nodes -x509 -subj "/C=IN/ST=Maharastra/L=Private/O=Dis/CN=www.google.com" -keyout /etc/ssl/novnc.key  -out /etc/ssl/novnc.cert && \
#Websockify
    npm i websockify && \
#MATE Desktop (remove "/app/.vubuntu/assets/packages/fluxbox.deb" from line 66 before uncommenting)
    #apt-get install -y \
    #ubuntu-mate-core \
    #ubuntu-mate-desktop && \
#XFCE Desktop (remove "/app/.vubuntu/assets/packages/fluxbox.deb" from line 66 before uncommenting)
    #apt-get install -y \
    #xubuntu-desktop && \
#TimeZone
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
#Brave - source
    curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|tee /etc/apt/sources.list.d/brave-browser-release.list && \
#Installation
    apt-get update && \
    apt-get install --no-install-recommends code brave-browser /tmp/peazip_8.2.0.LINUX.GTK2-1_amd64.deb sublime-text /tmp/packages-microsoft-prod.deb -y && \
    apt-get update && \
    apt-get install --no-install-recommends -y powershell && \
#Ngrok
    wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -P /tmp && \
    unzip /tmp/ngrok-stable-linux-amd64.zip -d /usr/bin && \
    ngrok authtoken $NGROK_AUTH_TOKEN && \
#Wipe Temp Files
    rm -rf /var/lib/apt/lists/* && \ 
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /tmp/*

ENTRYPOINT ["supervisord", "-l", "/app/.vubuntu/assets/logs/supervisord.log", "-c"]

CMD ["/app/.vubuntu/assets/configs/supervisordconf"]
