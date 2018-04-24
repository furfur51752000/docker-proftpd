FROM ubuntu:16.04

# install ProFTP
RUN apt-get -y update && \
    apt-get install -y proftpd openssl openssh*

# generate cert
RUN mkdir /etc/proftpd/ssl && \
    openssl req -new -x509 -days 365 -nodes -out /etc/proftpd/ssl/proftpd.cert.pem -subj "/C=TW/ST=Taiwan/L=Taipei/O=104corp/OU=104corp/CN=www.104.com.tw" -keyout /etc/proftpd/ssl/proftpd.key.pem && \
    chmod 600 /etc/proftpd/ssl/proftpd.*

# copy the file - proftpd config
COPY *.conf /etc/proftpd/

# add user
RUN useradd -m -d /home/ftpusert -s /bin/false ftpuser && \
	echo 'ftpuser:ftppass' | /usr/sbin/chpasswd

EXPOSE 21
