#!/bin/bash

set -e

SOURCE_SERVER_XML=/stash-server.xml
SERVER_XML=${STASH_INSTALL_DIR}/current/conf/server.xml
if [ "${STASH_PROXY_NAME}" != "" -a "${STASH_PROXY_PORT}" != "" ]
then
  sed "s/PROXY_SETTINGS/proxyName=\"${STASH_PROXY_NAME}\" proxyPort=\"${STASH_PROXY_PORT}\"/g" <${SOURCE_SERVER_XML} >${SERVER_XML}
else
  sed 's/PROXY_SETTINGS//g' <${SOURCE_SERVER_XML} >${SERVER_XML}
fi

chown -R ${STASH_USER}:${STASH_GROUP} ${STASH_HOME}
su ${STASH_USER} -c "$@"
