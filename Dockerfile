FROM ubuntu:16.04

# install ProFTP
RUN apt-get -y update && \
    apt-get install -y proftpd vim openssh*

# copy the file - openssl
RUN mkdir /etc/proftpd/ssl
COPY cert/proftpd.cert.pem /etc/proftpd/ssl/
	 cert/proftpd.key.pem /etc/proftpd/ssl/
RUN chmod 600 proftpd.*

# copy the file - proftpd config
COPY proftpd.conf /etc/proftpd/
	 tls.conf /etc/proftpd/

# add user
RUN useradd -m -d /home/ftpusertest -s /bin/false ftpusertest
	echo ftpuser:ftppass | /usr/sbin/chpasswd

# start the service
RUN systemctl restart proftpd.service
	systemctl enable proftpd.service

EXPOSE 21
