.PHONY: install test clean pre-commit

install:
	cp ssl-ca /usr/local/bin/ssl-ca
	chmod 755 /usr/local/bin/ssl-ca

test: clean
	bats --tap tests/

pre-commit:
	pre-commit run --all-files

clean:
	[ ! -f .server.pid ] || kill "$$(cat .server.pid)"
	git clean -Xdf
