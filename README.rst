SSL-CA
######

This utility automates generating an SSL certificate authority, keys and signed
certificates. The only dependecy is openssl.

Installation
------------
::

    git clone https://www.shore.co.il/cgit/ssl-ca
    cd ssl-ca
    sudo make install

Usage
-----

This will generate, inside the new directory, the directory stucture, a starting
configuration for starting work and a new CA key and certificate. ::

    $ mkdir domain.tld
    $ cd domain.tld
    $ ssl-ca init
    Generating RSA private key, 512 bit long modulus
    .++++++++++++
    ......++++++++++++
    e is 65537 (0x10001)

To generate a new key and certificate for the www host, the key will at
``keys/www`` and the certificate at ``certs/www`` ::

    $ ssl-ca gen www
    Generating RSA private key, 512 bit long modulus
    ................................++++++++++++
    ..++++++++++++
    e is 65537 (0x10001)
    Signature ok
    subject=/CN=*.*.www.domain.tld
    Getting CA Private Key

To sign existing keys, copy them to the ``keys/`` folder. All keys that don't
have a matching certificate under ``certs/`` will be signed when running ::

    $ openssl genrsa -out keys/smtp #Generate a key for smtp.domain.tld
    $ ssl-ca sign
    Signature ok
    subject=/CN=*.*.smtp.domain.tld
    Getting CA Private Key

To resign **ALL** existing keys (regardles of existing certificates) ::

    $ ssl-ca resign
    Signature ok
    subject=/CN=*.*.smtp.domain.tld
    Getting CA Private Key
    Signature ok
    subject=/CN=*.*.www.smtp.domain.tld
    Getting CA Private Key

License
-------

This software is licnesed under the MIT licese (see the ``LICENSE.txt`` file).

Author
------

Nimrod Adar.

TODO
----

- Add checks and failure messages to each action.
- Verify that the fqdn is correct.
- Testing (creating a ca, creating a key and cert and verifying).
