### nginx SSL Configuration
This is a sample configuration of nginx with SSL for [PFS (Perfect Forward Secrecy)](PFS). 

This configuration includes:

* The server prefers using [ECDHE] for key exchange
* It sends back [HSTS] headers on all SSL requests
* It sends back an X-Frame-Options DENY header to prevent [Clickjacking]

### Vagrant
To setup the test server run `vagrant up`.

The setup script will:

1. Install nginx
2. Generate a new private key
3. Create a self signed certificate
4. Configure nginx to use it

[PFS]: http://en.wikipedia.org/wiki/Perfect_forward_secrecy
[ECDHE]: http://en.wikipedia.org/wiki/ECDHE
[HSTS]: http://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security
[Clickjacking]: http://en.wikipedia.org/wiki/Clickjacking#X-Frame-Options
