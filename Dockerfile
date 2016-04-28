FROM alpine:3.3
MAINTAINER Mac Liu <linuzilla@gmail.com>

ENV PYTHON_VERSION=2.7.11-r3
ENV PY_PIP_VERSION=7.1.2-r0
ENV SUPERVISOR_VERSION=3.2.3

RUN apk update \
    && apk add openssh

RUN apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION
RUN pip install supervisor==$SUPERVISOR_VERSION

RUN rm -rf /var/cache/apk/* && rm -rf /tmp/src

RUN mkdir /root/.ssh
RUN chmod 700 /root/.ssh

ADD id_rsa.pub /root/.ssh/authorized_keys
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
COPY supervisord.conf /etc/supervisord.conf
RUN chmod 600 /root/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/bin/supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf" ]
