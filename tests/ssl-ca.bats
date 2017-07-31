#!/usr/bin/env bats

export PATH="$BATS_TEST_DIRNAME/../:$PATH"

setup () {
    make clean
    ./ssl-ca init
}

teardown () {
    make clean
}

verify () {
    openssl verify -CAfile CA.crt "$1"
}

match () {
    cmp <(openssl pkey -pubout -outform PEM -in "$1") <(openssl x509 -pubkey -noout -in "$2")
}

@test "init" {
    [ "$(openssl rsa -noout -check -in CA.key)" = "RSA key ok" ]
    [ "$(openssl verify -CAfile CA.crt CA.crt)" = "CA.crt: OK" ]
    ./ssl-ca init
}

@test "generate cert" {
    ./ssl-ca gen www
    verify certs/www
    match keys/www certs/www
    [ "$(openssl rsa -noout -check -in keys/www)" = "RSA key ok" ]
    [ "$(openssl x509 -in certs/www -issuer -noout)" = "issuer=CN = ssl-ca" ]
    [ "$(openssl x509 -in certs/www -subject -noout)" = "subject=CN = www.ssl-ca" ]

}

@test "sign cert" {
    openssl genrsa -out keys/smtp
    ./ssl-ca sign
    verify certs/smtp
    match keys/smtp certs/smtp
    [ "$(openssl x509 -in certs/smtp -issuer -noout)" = "issuer=CN = ssl-ca" ]
    [ "$(openssl x509 -in certs/smtp -subject -noout)" = "subject=CN = smtp.ssl-ca" ]

}

@test "resign" {
    ./ssl-ca gen www
    openssl genrsa -out keys/smtp
    ./ssl-ca sign
    verify certs/www
    match keys/www certs/www
    verify certs/smtp
    match keys/smtp certs/smtp
    [ "$(openssl x509 -in certs/www -issuer -noout)" = "issuer=CN = ssl-ca" ]
    [ "$(openssl x509 -in certs/www -subject -noout)" = "subject=CN = www.ssl-ca" ]
    [ "$(openssl x509 -in certs/smtp -issuer -noout)" = "issuer=CN = ssl-ca" ]
    [ "$(openssl x509 -in certs/smtp -subject -noout)" = "subject=CN = smtp.ssl-ca" ]
}

@test "webserver" {
    ./ssl-ca gen www
    openssl s_server -cert certs/www -key keys/www -CAfile CA.crt -quiet -www -no_dhe &
    echo "$!" > .server.pid
    run curl --fail --cacert CA.crt --resolve www.ssl-ca:4433:127.0.0.1 --write-out '%{ssl_verify_result}' --silent --output /dev/null https://www.ssl-ca:4433/
    [ "$output" = "0" ]
    [ "$status" -eq 0 ]
    kill "$(cat .server.pid)"
    rm .server.pid
}
