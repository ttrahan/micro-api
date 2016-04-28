FROM mhart/alpine-node:0.10

RUN apk add --no-cache bash

# this folder must be created in the base images
ADD . /root/micro-api/

ENV API_PORT=80 DEBUG_LEVEL=error SHUD_LOG_TO_FILE=true

#now run set up
RUN /bin/bash /root/micro-api/setup.sh

ENTRYPOINT ["/root/micro-api/boot.sh"]
