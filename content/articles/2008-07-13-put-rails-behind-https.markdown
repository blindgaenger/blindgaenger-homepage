---
layout: post
title: Put Rails behind HTTPS
tags:
- wzuup
- nginx
- rails
- ssl
---

[http://benr75.com/2008/04/09/force-ssl-for-a-rails-application-with-an-nginx-proxy](http://benr75.com/2008/04/09/force-ssl-for-a-rails-application-with-an-nginx-proxy)

Set `X_FORWARDED_PROTO` in `nginx.conf`:
{% highlight bash %}
server {
  ...
  location {
    ...
    proxy_set_header X_FORWARDED_PROTO https;
    ...
  }
...
}
{% endhighlight %}

Rails will figure out from these lines in `request.rb`:
{% highlight ruby %}
def ssl?
      @env['HTTPS'] == 'on' || @env['HTTP_X_FORWARDED_PROTO'] == 'https'
end
{% endhighlight %}
