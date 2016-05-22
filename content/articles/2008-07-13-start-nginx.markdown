---
layout: post
title: Start Nginx
tags:
- wzuup
- nginx
---

Check it's not running.
{% highlight bash %}
$ curl localhost
curl: (7) couldn't connect to host
{% endhighlight %}

Start it directly (without init.d script)
{% highlight bash %}
$ sudo /usr/local/nginx/sbin/nginx
{% endhighlight %}

Check it's running in the background.
{% highlight bash %}
$ curl localhost
<html>
<head>
<title>Welcome to nginx!</title>
</head>
<body bgcolor="white" text="black">
<center><h1>Welcome to nginx!</h1></center>
</body>
</html>
{% endhighlight %}

Stop/kill the server again.
{% highlight bash %}
$ sudo kill `cat /usr/local/nginx/logs/nginx.pid`
{% endhighlight %}

Check it's not running.
{% highlight bash %}
$ curl localhost
curl: (7) couldn't connect to host
{% endhighlight %}

# Notes

If the server needs a pass phrase on start up, see 
[Generate SSL certificate](/generate-ssl-certificate) how to avoid this.
{{bash
$ sudo /etc/init.d/nginx start
Starting nginx: Enter PEM pass phrase:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
nginx.
}}

