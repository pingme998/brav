FROM dorowu/ubuntu-desktop-lxde-vnc
RUN apt update
RUN apt install nano -y
ENV RESOLUTION="1920x1080"
ENV BRAVE_USE_SHM=0
RUN curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|tee /etc/apt/sources.list.d/brave-browser-release.list
RUN apt update
RUN apt-get install --no-install-recommends brave-browser -y
COPY def /def 
