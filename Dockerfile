# Starting from ubuntu vs alpine to avoid all the random alpine issues
FROM ubuntu:latest

# Install supervisord, xvfb, and vnc server
RUN apt-get update -y && \
    apt-get install -y \
        supervisor \
        xvfb \
        x11vnc && \
    apt-get clean

# Some overriddable env variables
ENV DISPLAY=1
ENV SCREEN=0
ENV DISPLAY_MODE=1024x768x16
ENV VNCPASSWD=1234

# expose port 6001 (6000+display). If DISPLAY is overridden, exposed port will be need to be specified as well
EXPOSE 6001

# expose 5900 for VNC
EXPOSE 5900

# Process config is in the supervisord conf file so just start that with the container
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]