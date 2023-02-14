FROM ubuntu:20.04

# Build Arguments
ARG ARM
ARG VERSION

# LABEL about the custom image
LABEL maintainer="benoit@alphatux.fr"
LABEL version=$VERSION
LABEL description="Massa node with massa-guard features"

# Update and install packages dependencies
RUN apt-get update \
&& apt install -y wget python3-pip \
&& python3 -m pip install -U discord.py==1.7.3

# Download the Massa package
COPY download-massa.sh .
RUN chmod u+x download-massa.sh \
&& ./download-massa.sh \
&& rm download-massa.sh

# Create massa-guard tree
RUN mkdir -p /massa-guard/sources \
&& mkdir -p /massa-guard/config

# Copy massa-guard sources
COPY massa-guard.sh /massa-guard/
COPY sources/cli.sh /cli.sh
COPY sources /massa-guard/sources
COPY config /massa-guard/config

# Conf rights
RUN chmod +x /massa-guard/massa-guard.sh \
&& chmod +x /massa-guard/sources/* \
&& chmod +x /cli.sh \
&& mkdir /massa_mount

# Node run then massa-guard
CMD [ "/massa-guard/sources/run.sh" ]
