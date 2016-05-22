---
layout: post
title: Use nginx config generator
tags:
- wzuup
- nginx
---

There is a [Config Generator for Nginx](http://github.com/defunkt/nginx_config_generator) 
which uses YAML for configuration. It uses the same keywords (hopefully it does), 
but may be easier to maintain.

Install nginx_config_generator
{% highlight bash %}
$ sudo gem install nginx_config_generator
{% endhighlight %}

Generate a YAML example as template
{% highlight bash %}
$ generate_nginx_config ‐‐example >nginx.yml
{% endhighlight %}

Convert the yaml to `nginx.conf`
{% highlight bash %}
$ generate_nginx_config nginx.yml nginx.conf
{% endhighlight %}

Use `-y` to overwrite nginx.conf if already exists
{% highlight bash %}
$ generate_nginx_config nginx.yml nginx.conf -y
{% endhighlight %}

