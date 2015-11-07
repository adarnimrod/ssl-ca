.PHONY: install clean test

install:
	cp ssl-ca /usr/local/bin/ssl-ca
	chmod 755 /usr/local/bin/ssl-ca

clean:
	rm -rf openssl.cnf certs keys CA.key CA.crt

test: clean
	./ssl-ca init
	./ssl-ca gen www
	openssl verify -CAfile CA.crt certs/www
	test "$$(openssl x509 -in certs/www -issuer -noout)" == "issuer= /CN=*.*.ssl-ca"
	test "$$(openssl x509 -in certs/www -subject -noout)" == "subject= /CN=*.*.www.ssl-ca"
	openssl genrsa -out keys/smtp
	./ssl-ca sign
	openssl verify -CAfile CA.crt certs/smtp
	test "$$(openssl x509 -in certs/smtp -issuer -noout)" == "issuer= /CN=*.*.ssl-ca"
	test "$$(openssl x509 -in certs/smtp -subject -noout)" == "subject= /CN=*.*.smtp.ssl-ca"
	./ssl-ca resign
	openssl verify -CAfile CA.crt certs/www
	openssl verify -CAfile CA.crt certs/smtp
	test "$$(openssl x509 -in certs/www -issuer -noout)" == "issuer= /CN=*.*.ssl-ca"
	test "$$(openssl x509 -in certs/www -subject -noout)" == "subject= /CN=*.*.www.ssl-ca"
	test "$$(openssl x509 -in certs/smtp -issuer -noout)" == "issuer= /CN=*.*.ssl-ca"
	test "$$(openssl x509 -in certs/smtp -subject -noout)" == "subject= /CN=*.*.smtp.ssl-ca"
