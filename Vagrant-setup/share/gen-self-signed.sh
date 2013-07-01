#!/bin/sh -e

# Thanks to this post for the bulk of this script: http://www.codenes.com/blog/?p=300

# $1 - FQDN (ex: foo.example.com)
# $2 - Filename prefix (ex: server becomes server.key/server.csr/server.crt)

echodo()
{
    echo "${@}"
    (${@})
}

yearmon()
{
    date '+%Y%m%d'
}

fqdn()
{
    echo $1
#
#    (nslookup ${1} 2>&1 ¦¦ echo Name ${1}) \
#        ¦ tail -3 ¦ grep Name¦ sed -e 's,.*e:[ \t]*,,'
}

C=
ST=
L=
O=
OU=
HOST=${1}
DATE=
CN=${1}

csr="${2}.csr"
key="${2}.key"
cert="${2}.crt"

# Create the certificate signing request
openssl req -new -passin pass:password -passout pass:password -out $csr -newkey rsa:4096 <<EOF
${C}
${ST}
${L}
${O}
${OU}
${CN}
$USER@${CN}
.
.
EOF
echo ""

[ -f ${csr} ] && echodo openssl req -text -noout -in ${csr}
echo ""

# Create the Key
openssl rsa -in privkey.pem -passin pass:password -passout pass:password -out ${key}

# Create the Certificate
openssl x509 -in ${csr} -out ${cert} -req -signkey ${key} -days 1000

