FROM ubuntu:18.04

RUN apt-get update --fix-missing && apt-get -y upgrade

# Install dependencies
RUN apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:projectatomic/ppa && \
    apt-get -y install git jq curl make xonsh && \
    apt-get -y install podman skopeo buildah && \
    apt-get -y clean && \
    apt-get -q -y autoremove

COPY scripts /scripts

RUN chmod +x /scripts/* && \
    cp /scripts/* /usr/local/bin
