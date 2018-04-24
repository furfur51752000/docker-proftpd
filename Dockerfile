FROM ubuntu:16.04

# install ProFTP
RUN apt-get -y update && \
    apt-get install -y proftpd vim openssh*

# copy the file - openssl
RUN mkdir /etc/proftpd/ssl
COPY cert/proftpd.* /etc/proftpd/ssl/
RUN chmod 600 /etc/proftpd/ssl/proftpd.*

# copy the file - proftpd config
COPY *.conf /etc/proftpd/

# add user
RUN useradd -m -d /home/ftpusert -s /bin/false ftpuser && \
	echo 'ftpuser:ftppass' | /usr/sbin/chpasswd

EXPOSE 21
