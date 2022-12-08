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
For route53 it took about 15 mins.

Then the nameserver changes need to propate around the internet

Check if the domain is pointing to the google nameservers yet with the host command:

```
sudo apt install host -y
host -t ns cruddur.com
```

You can also use the following online tool to check based on what different networks see:
https://dnschecker.org/ns-lookup.php


While you are updating the nameserver you might get:
```
Host cruddur.com not found: 2(SERVFAIL)
```

Just give it time to propagte