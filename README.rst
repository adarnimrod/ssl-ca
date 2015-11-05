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

To generate a new key and certificate for the www host, the key will at
``keys/www`` and the certificate at ``certs/www`` ::

    $ ssl-ca gen www

To sign existing keys, copy them to the ``keys/`` folder. All keys that don't
have a matching certificate under ``certs/`` will be signed when running ::

    $ ssl-ca sign

To resign **ALL** existing keys (regardles of existing certificates) ::

    $ ssl-ca resign

License
-------

This software is licnesed under the MIT licese (see the ``LICENSE.txt`` file).

Author
------

Nimrod Adar.

TODO
----

- Fill out example output in the usage section.
- Add checks and failure messages to each action.
- Finish openssl configuration.
