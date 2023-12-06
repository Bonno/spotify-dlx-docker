FROM python:3-alpine

LABEL maintainer="xnetcat (Jakub)"

# Install dependencies
RUN apk add --no-cache \
    ca-certificates \
    ffmpeg \
    openssl \
    aria2 \
    #g++ \
    git \
    py3-cffi \
    libffi-dev \
    zlib-dev

RUN pip3 install git+https://github.com/kokarare1212/librespot-python --upgrade
RUN pip3 install spotify_dlx --upgrade

# Create music directory
RUN addgroup -g 1000 -S spotify
RUN adduser -h /home/spotify -s /bin/sh -G spotify -S -u 1000 spotify 

RUN mkdir /music
RUN chown -R spotify:spotify /music

# Create a volume for the output directory
VOLUME /music

# Change CWD to /music
WORKDIR /music

# Link our download location to /music in the container
#VOLUME ["/data"]

#RUN chown -R spotify:spotify /home/spotify

USER spotify

#CMD ["su", "-", "spotify", "-c", "/bin/bash"]
#CMD ["su", "-", "spotify", "-c", "python3", "-m", "spotify_dlx"]
#CMD ["su", "-", "spotify", "-c", "/bin/sh"]
CMD ["/bin/sh"]
