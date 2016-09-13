# Joyent TCP Puzzlers Continued...

A re-enactment of the [Joyent Puzzler article](https://www.joyent.com/blog/tcp-puzzlers), this time on FreeBSD and traced with DTrace.

## Vagrant
Start servers

    $ cd kang && vagrant up
    $ cd kodos && vagrant up

## Server
Execute the following commands each in their own terminal:

    $ sudo dtrace -q -s /vagrant/dtrace_server.d
    $ sudo dtrace -q -s /vagrant/tcpstate.d
    $ nc -k -l 10.0.1.10 8080

## Client
Same for client, each in their own terminal

    $ sudo dtrace -q -s /vagrant/dtrace_server.d
    $ sudo dtrace -q -s /vagrant/tcpstate.d
    $ nc -k -l 10.0.1.10 8080
