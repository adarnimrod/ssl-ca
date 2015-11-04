SSL-CA
######

This is a program (written in POSIX shell) to generate an SSL/TLS certificate
authority, signed certificates and to sign existing certificates.

Installation
------------
::

    git clone https://www.shore.co.il/cgit/ssl-ca
    cd ssl-ca
    sudo make install

The dependencies are openssl and a POSIX shell.

Usage
-----

To start a new CA ::

    $ ssl-ca init workca

This will create a new directory with the directory structure and an example
configuration file. **Remember to change the configuration in the config file.**

To generate a new CA key and certificate (inside the new directory)::

    $ ssl-ca ca-gen

To generate a new key and certificate for the www.example.com domain ::

    $ ssl-ca gen www.example.com

The key will be at ``keys/www.example.com.key`` and the certificate at
``certs/www.example.com.pem``.

To sign existing keys, copy them to ``keys/subdomain.domain.tld.key`` and run (this will sign all of keys found under ``keys/``) ::

    $ ssl-ca sign

To resign **ALL** existing keys (overriding existing certificates) ::

    $ ssl-ca resign

Example config
--------------
::

    # This file is sourced by ssl-ca, so comments start with #
    # and usual shell evaluation and variables can be used.
    # No setting is mandatory and missing setting will be left blank or the
    # default value will be used.
    keysize=2048
    keytype='rsa'
    cipher='aes256'
    days=365
    countrycode='US'
    state='Somewhere'
    locality='Some other place.'
    orgname='Acme'
    orgunit='Widgets'
    email='hostmaster@example.com'

License
-------

This software is licnesed under the MIT licese (see the LICENSE.txt file).

Author
------

Nimrod Adar.

TODO
----

- Write said program.
- Fill out example output in the usage section.
