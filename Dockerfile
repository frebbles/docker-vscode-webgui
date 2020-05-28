# Docker file for running vs code-server by cdr on github for a browser
# based vscode
# Run with
# docker run -ti --rm -p 8080:8080 -v $(pwd)/code:/code webvscode:v1
# then open browser in host to localhost:8080

FROM ubuntu:18.04

# For setting up the user, should be the same as host system for sanity
ARG UID=1000
ARG GID=1000

# Package repo update and refresh to current
RUN apt-get -y update && \
    apt-get -y upgrade

# Packages required for vscode-server function
RUN apt-get -y install wget
RUN apt-get -y install netcat
RUN apt-get -y install sudo
RUN apt-get -y install net-tools
RUN apt-get -y install git git-core

# This is the 'hardest' coded part, TODO: update this to use latest instead!
# download the coder binary, untar it, and allow it to be executed
RUN wget https://github.com/cdr/code-server/releases/download/v3.3.1/code-server-3.3.1-linux-x86_64.tar.gz \
    && tar -xzvf code-server-3.3.1-linux-x86_64.tar.gz && chmod +x code-server-3.3.1-linux-x86_64/code-server

# Setup user and group
RUN groupadd -g $GID -o user

RUN useradd -u $UID -m -g user -G plugdev user \
        && echo 'user ALL = NOPASSWD: ALL' > /etc/sudoers.d/user \
        && chmod 0440 /etc/sudoers.d/user

# Run the following final commands as 'user' code-server prefers non poweruser
USER user

RUN code-server-3.3.1-linux-x86_64/code-server \
        --user-data-dir=/home/user/.vscode/ \
	--extensions-dir=/home/user/.vscode-oss/extensions/ \
	--install-extension ms-vscode.cpptools

RUN code-server-3.3.1-linux-x86_64/code-server \
        --user-data-dir=/home/user/.vscode/ \
	--extensions-dir=/home/user/.vscode-oss/extensions/ \
	--install-extension marus25.cortex-debug

COPY docker-entrypoint.sh /usr/local/bin/

ADD ./code /code

ENTRYPOINT ["docker-entrypoint.sh"]
