SSL-CA
######

This utility automates generating an SSL certificate authority, keys and signed
certificates. The dependencies are: OpenSSL, cURL git and make (for testing and
installation, although you can just copy the file). The use case in mind is
testing and internal environments, therefore some security measures (like
revocation) are not available in the current implementation.

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


The certs by themselves are the same as self-signed certs, but once you add
``CA.crt`` to your browser (or OS), then the certs will be valid as any other
cert on the internet.

Development
-----------

For easing devlopment ``make test`` and ``make clean`` are also provided (it's
recommended to add ``make test`` to the pre-push git hook).

License
-------

This software is licnesed under the MIT licese (see the ``LICENSE.txt`` file).

Author
------

Nimrod Adar, `contact me <nimrod@shore.co.il>`_ or visit my `website
<https://www.shore.co.il/>`_. Patches are welcome via `git send-email
<http://git-scm.com/book/en/v2/Git-Commands-Email>`_. The repository is located
at: https://www.shore.co.il/cgit/.

TODO
----
