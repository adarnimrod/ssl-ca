.PHONY: install clean test

install:
	cp ssl-ca /usr/local/bin/ssl-ca
	chmod 755 /usr/local/bin/ssl-ca

clean:
	rm -rf openssl.cnf certs keys CA.key CA.crt

test: clean
	./ssl-ca init
	./ssl-ca gen www
	openssl genrsa -out keys/smtp
	./ssl-ca sign
	./ssl-ca resign
