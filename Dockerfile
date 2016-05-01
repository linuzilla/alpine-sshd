FROM alpine:3.3
MAINTAINER Mac Liu <linuzilla@gmail.com>

ENV PYTHON_VERSION=2.7.11-r3
ENV PY_PIP_VERSION=7.1.2-r0
ENV SUPERVISOR_VERSION=3.2.3

RUN apk update \
    && apk add openssh ; \
    apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION; \
    pip install supervisor==$SUPERVISOR_VERSION; \
    rm -rf /var/cache/apk/* && rm -rf /tmp/src; \
    mkdir /etc/supervisor.d; \
    mkdir /etc/init-scripts; \
    mkdir /etc/settings.d

COPY supervisord.conf /etc/supervisord.conf
COPY sshd.conf /etc/supervisor.d/sshd.conf
COPY 01init-ssh.sh /etc/init-scripts
COPY initrc.sh /sbin
RUN chmod 755 /etc/init-scripts/01init-ssh.sh; \
	chmod 755 /sbin/initrc.sh

VOLUME [ "/etc/settings.d" ]
EXPOSE 22
CMD ["/sbin/initrc.sh"]
