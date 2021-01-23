# SSL-CA

[![pipeline status](https://git.shore.co.il/nimrod/ssl-ca/badges/master/pipeline.svg)](https://git.shore.co.il/nimrod/ssl-ca/-/commits/master)

This utility automates generating an SSL certificate authority, keys and
signed certificates. The only dependency is OpenSSL (and base utils).
Make and Git are needed for installation (although one can just download
and copy `ssl-ca`{.sourceCode}). The use case in mind is testing and
internal environments, therefore some security measures (like
revocation) are not available in the current implementation.

## Installation

```shell
git clone https://www.shore.co.il/cgit/ssl-ca
cd ssl-ca
sudo make install
```

## Usage

This will generate, inside the new directory, the directory structure, a
starting configuration for starting work and a new CA key and
certificate. :

```
$ mkdir domain.tld
$ cd domain.tld
$ ssl-ca init
Generating RSA private key, 512 bit long modulus
.++++++++++++
......++++++++++++
e is 65537 (0x10001)
```

To generate a new key and certificate for the www host, the key will at
`keys/www` and the certificate at `certs/www` :

```
$ ssl-ca gen www
Generating RSA private key, 512 bit long modulus
................................++++++++++++
..++++++++++++
e is 65537 (0x10001)
Signature ok
subject=/CN=*.*.www.domain.tld
Getting CA Private Key
```

To sign existing keys, copy them to the `keys/` folder. All keys that
don't have a matching certificate under `certs/` will be signed when
running :

```
$ openssl genrsa -out keys/smtp #Generate a key for smtp.domain.tld
$ ssl-ca sign
Signature ok
subject=/CN=*.*.smtp.domain.tld
Getting CA Private Key
```

To resign **ALL** existing keys (regardless of existing certificates) :

```
$ ssl-ca resign
Signature ok
subject=/CN=*.*.smtp.domain.tld
Getting CA Private Key
Signature ok
subject=/CN=*.*.www.smtp.domain.tld
Getting CA Private Key
```

The certs by themselves are the same as self-signed certs, but once you
add `CA.crt`{.sourceCode} to your browser (or OS), then the certs will
be valid as any other cert on the internet.

## Development

Requirements are:

- Python (2.7 or 3.5 or later).
- Make.
- Git.
- Bats.

Tests are written using [Bats](https://github.com/sstephenson/bats) and
some linters are used with [pre-commit](http://pre-commit.com/). The
`clean`{.sourceCode}, `test`{.sourceCode} and `pre-commit`{.sourceCode}
Make targets are provided. Installing the pre-commit Git hooks is
recommended.

## License

This software is licensed under the MIT license (see `LICENSE.txt`).

## Author Information

Nimrod Adar, [contact me](mailto:nimrod@shore.co.il) or visit my
[website](https://www.shore.co.il/). Patches are welcome via
[`git send-email`](http://git-scm.com/book/en/v2/Git-Commands-Email). The repository
is located at: <https://git.shore.co.il/explore/>.
