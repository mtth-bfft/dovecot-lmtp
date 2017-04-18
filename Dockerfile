FROM alpine:latest
LABEL maintainer "Matthieu Buffet <mtth.bfft@gmail.com>"
LABEL version="1.0"

EXPOSE 24 110 995 143 993

CMD ["/usr/sbin/dovecot","-F"]
HEALTHCHECK CMD ! doveadm service status | grep -ri "^exit_failure" | grep -rvq " 0$"

RUN apk add --no-cache dovecot && \
	rm -rf /etc/ssl/dovecot /etc/dovecot/users && \
	adduser -h /var/mail/ -u 5000 -S -s /sbin/nologin vmail && \
	chmod o-rwx /var/mail/

VOLUME ["/var/mail/"]

COPY dovecot.conf /etc/dovecot/
COPY conf.d/ /etc/dovecot/conf.d/
