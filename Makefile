.PHONY: install test clean pre-commit

install:
	install -m 755 ssl-ca /usr/local/bin/ssl-ca

clean:
	- kill "$$(cat .server.pid)"
	git clean -Xdf
