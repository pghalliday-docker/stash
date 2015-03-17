FROM ubuntu:latest

ENV ATLASSIAN_HOME=/var/atlassian/application-data \
    STASH_USER=stash \
    STASH_GROUP=stash \
    STASH_CHECKSUM=a217e71fed08113fadf8402f5bd9a0ce3257042bc2cbeb35af8276fff31498ac \
    STASH_BASENAME=atlassian-stash-3.7.1 \
    STASH_INSTALL_DIR=/opt/atlassian/stash

ENV STASH_HOME=${ATLASSIAN_HOME}/stash \
    STASH_TARBALL=${STASH_BASENAME}.tar.gz

ENV STASH_URL=https://www.atlassian.com/software/stash/downloads/binary/${STASH_TARBALL}

RUN apt-get update \
    && apt-get install -y \
    wget \
    openjdk-7-jre \
    git \
    perl

RUN mkdir -p ${ATLASSIAN_HOME} \
    && groupadd -r ${STASH_GROUP} \
    && useradd -r -m -g ${STASH_GROUP} -d ${STASH_HOME} ${STASH_USER} \
    && mkdir -p ${STASH_INSTALL_DIR} \
    && chown -R ${STASH_USER}:${STASH_GROUP} ${STASH_INSTALL_DIR}

WORKDIR ${STASH_INSTALL_DIR}
RUN wget -q ${STASH_URL} \
    && echo ${STASH_CHECKSUM} ${STASH_TARBALL} | sha256sum -c - \
    && tar zxf ${STASH_TARBALL} \
    && rm ${STASH_TARBALL} \
    && ln -s ${STASH_BASENAME} current \
    && chown -R ${STASH_USER}:${STASH_GROUP} current/logs \
    && chown -R ${STASH_USER}:${STASH_GROUP} current/temp \
    && chown -R ${STASH_USER}:${STASH_GROUP} current/work

WORKDIR ${STASH_INSTALL_DIR}/current/bin
EXPOSE 7990
CMD chown -R ${STASH_USER}:${STASH_GROUP} ${STASH_HOME} \
    && su ${STASH_USER} -c "./start-stash.sh -fg"
