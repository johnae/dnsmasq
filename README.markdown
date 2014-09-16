### Dnsmasq for docker

To get going create a data volume for persistence and sharing like so:

```docker run --name dnsmasq-data -v /etc/dnsmasq.d busybox```

Add a host like so:

```docker run --volumes-from=dnsmasq-data johnae/dnsmasq set_host <hostname>,<ip>```

Usually I add a domain like so:

```set_host base.domain.com,1.2.3.4```

Then I add each host under that domain like so:

```set_host host-a.base.domain.com,1.3.2.5```

Finally run (or restart) the dnsmasq container like so:

```docker run -d -p 53:53/udp --name dnsmasq --volumes-from=dnsmasq-data johnae/dnsmasq```


docker run -d -p 172.17.42.1:533:53/udp --volumes-from=dnsmasq-data johnae/dnsmasq
