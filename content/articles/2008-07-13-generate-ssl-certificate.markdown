---
layout: post
title: Generate SSL certificate
tags:
- wzuup
- ssl
---

[http://www.akadia.com/services/ssh_test_certificate.html](http://www.akadia.com/services/ssh_test_certificate.html)

# Generate a complex pass-phrase.

In the following it's shown as XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX.


# Generate a CSR (Certificate Signing Request) 

{% highlight bash %}
$ openssl genrsa -des3 -out wzuup.key 1024
Generating RSA private key, 1024 bit long modulus
...............................++++++
.................................++++++
e is 65537 (0x10001)
Enter pass phrase for cert.key:
Verifying - Enter pass phrase for wzuup.key:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
{% endhighlight %}


# Generate a CSR (Certificate Signing Request) 

{% highlight bash %}
$ sudo openssl req -new -key wzuup.key -out wzuup.csr
Enter pass phrase for wzuup.key:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:DE
State or Province Name (full name) [Some-State]:Baden-Württemberg
Locality Name (eg, city) []:Karlsruhe
Organization Name (eg, company) [Internet Widgits Pty Ltd]:WZUUP.de
Organizational Unit Name (eg, section) []:
Common Name (eg, YOUR name) []:www.wzuup.de
Email Address []:kontakt@wzuup.de

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
{% endhighlight %}


# Remove Passphrase from Key

{% highlight bash %}
$ sudo cp wzuup.key wzuup.key.org
$ sudo openssl rsa -in wzuup.key.org -out wzuup.key
Enter pass phrase for wzuup.key.org:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
writing RSA key
{% endhighlight %}


# Self-sign certificate

Create a self-signed certificate, which is valid to for 365 days. 
So it will not officially be cerificated by the certification authority.
The request is useless for self-signed certificates.

{% highlight bash %}
$ sudo openssl x509 -req -days 365 -signkey wzuup.key -in wzuup.csr -out wzuup.crt
Signature ok
subject=/C=DE/ST=Baden-W\xC3\xBCrttemberg/L=Karlsruhe/O=WZUUP.de/CN=www.wzuup.de/emailAddress=kontakt@wzuup.de
Getting Private key
{% endhighlight %}

# Use the certificate

Now you have four files:
* `wzuup.key.org`: the certificate key with passphrase
* `wzuup.key`: the certificate key without passphrase
* `wzuup.csr`: the request for the certificate
* `wzuup.crt`: the self-signed certificate

But only upload and use `wzuup.key` and `wzuup.crt` in your applications.

Done!
