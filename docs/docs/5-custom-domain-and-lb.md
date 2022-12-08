## Create a Custom DNS


- Enable Cloud DNS
- Create a new Zone eg. cruddur / cruddur.com

### Update Nameserver

Click into the new hosted zone.
Get the nameservers for your zone by clicking "Registrar Setup"

So for mine it was this but it could be different.
```
ns-cloud-e1.googledomains.com.
ns-cloud-e2.googledomains.com.
ns-cloud-e3.googledomains.com.
ns-cloud-e4.googledomains.com.
```

I am using Route53 so I updated the name servers

### Verify

It will take a bit of time for your domain provider to update the nameservers.
For route53 it took about 5 mins.

Then the nameserver changes need to propate around the internet

Check if the domain is pointing to the google nameservers yet with the host command:

```
sudo apt install host -y
host -t ns cruddur.com
```

You can also use the following online tool to check based on what different networks see:
https://dnschecker.org/ns-lookup.php


If you get an error like this it could mean you set the DNS records incorrectly
```
Host cruddur.com not found: 2(SERVFAIL)
```

## Load Balancer

> Update Terraform with GCP LB Module

## Connect domain to Load Balancer

Create a new A record with the Load Balancer's domain.
If you check the load balancers frontends both the addresses will be the same. That is hte load balancers IP Addres

We'll use ping to confirm the domain is returning the IP address we set

```
ping cruddur.com
```

So I get back this

```
PING cruddur.com (34.117.127.252) 56(84) bytes of data.
64 bytes from 252.127.117.34.bc.googleusercontent.com (34.117.127.252): icmp_seq=1 ttl=113 time=1.00 ms
64 bytes from 252.127.117.34.bc.googleusercontent.com (34.117.127.252): icmp_seq=2 ttl=113 time=0.310 ms
64 bytes from 252.127.117.34.bc.googleusercontent.com (34.117.127.252): icmp_seq=3 ttl=113 time=0.374 ms
```

## Confirm SSL is working

In the load balancer tab if you go into `cruddur-lb-url-map`

You can see here on Frontend the certificate for `cruddur-lb-cert`

Lets confirm its out of provisioning

This can take 30 to 60 mins on average to leave PROVISIONG

https://cloud.google.com/load-balancing/docs/ssl-certificates/troubleshooting?&_ga=2.176251298.-668636557.1639844807#certificate-managed-status

