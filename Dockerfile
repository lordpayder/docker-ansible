FROM        python:alpine

RUN         apk --update add --no-cache --virtual temp-dependencies \
            build-base \
            openssl-dev \
            libffi-dev &&\
            apk add --no-cache openssh-client \
            ca-certificates \
            sshpass &&\
            pip install ansible pywinrm &&\
            apk del temp-dependencies &&\
            rm -rf /var/cache/apk/* &&\
            mkdir /ansible &&\
            addgroup -g 1100 ansible &&\
            adduser --disabled-password --uid 1100 --ingroup ansible ansible &&\
            chown ansible:ansible /ansible &&\
            chmod -R 700 /ansible &&\
            chown ansible:ansible /usr/local/bin/ansible

COPY        ./ansible.cfg /ansible/ansible.cfg

USER        ansible

WORKDIR     /ansible
