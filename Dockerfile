FROM ubuntu:25.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    fortune-mod \
    cowsay \
    netcat-openbsd && \
    apt-get clean && \
    ln -s /usr/games/cowsay /usr/bin/cowsay && \
    ln -s /usr/games/fortune /usr/bin/fortune

WORKDIR /app
COPY app.sh .
RUN chmod +x app.sh
EXPOSE 4499
CMD ["./app.sh"]