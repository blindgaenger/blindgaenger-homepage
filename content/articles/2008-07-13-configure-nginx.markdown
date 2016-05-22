---
title: Configure Nginx
tags:
- wzuup
- nginx
---

Note that these config worked well for me. Please check your needs and read the 
official documentation about [Nginx Configuration](http://wiki.nginx.org/NginxConfiguration)
befor using it for your projects.

If you followed the instructions described in my previous post 
[Compile Nginx](compile-nginx.html), then the configuration is located in 
`/usr/local/nginx/conf/nginx.conf`.

# Configuration

Basically it looks like this. The missing server configs are described in detail
below.

{% highlight bash %}
# user and group to run as
#user   nginx nginx;

worker_processes  1;
events {
  # Number of worker connections. 1024 is a good default
  worker_connections  1024;
}

http {
  include mime.types;
  default_type application/octet-stream;

  access_log logs/access.log;
  error_log logs/error.log debug;

  # no sendfile on OSX 
  sendfile on;

  # These are good default values.
  tcp_nopush on;
  tcp_nodelay off;

  # output compression saves bandwidth 
  gzip on;
  gzip_http_version 1.0;
  gzip_comp_level 2;
  gzip_proxied any;
  gzip_types text/plain text/html text/css application/x-javascript text/xml application/xml application/xml+rss text/javascript;
  
  ##################################
  # include your server configs here
  ##################################

}
{% endhighlight %}


# Static pages

This server config served our static "coming soon" page. Actually the page was
hosted somewhere in the internet at `http://wzuup.de`. What I needed to do is to
redirect the content to `wzuup.com`. Users entering `www.wzuup.com` will be 
permanently rewritten to `wzuup.com`. Pretty simple if you try to read it!

{% highlight bash %}
##################################
# http://wzuup.com

server {
  listen       80;
  server_name  wzuup.com www.wzuup.com;
  access_log   logs/wzuup.access.log;

  # www.wzuup.com => wzuup.com
  if ($host ~* "www") {
    rewrite ^(.*)$ http://wzuup.com$1 permanent;
    break;
  }

  location / {
    # redirect the request
    # so http://wzuup.de/ will appear at http://wzuup.com/
    proxy_pass        http://wzuup.de;
    proxy_set_header  X-Real-IP  $remote_addr;
  }

  error_page   500 502 503 504  /50x.html;
  location = /50x.html {
    root   html;
  }
}
{% endhighlight %}


# Rails application

At staging we share our last stable build with the rest of the team or some 
chosen people. That's why it uses `ssl` and `auth_basic`.

The interesting part is the `mongrel_staging` section. Mongrel instance on
ports 8001 and 8001 are serving our Rails app. Nginx tries to server the 
requested files from its `root` dir (see config). But if the filename does not 
exist (`if (!-f $request_filename)`) then the request is passed to one mongrel.

Of course, you can put multiple mongrel instances in the `upstream` section. For
Rails projects register all servers of a specific cluster. Nginx tries to load
balance them. ([http://wiki.nginx.org/NginxChsHttpUpstreamModule](http://wiki.nginx.org/NginxChsHttpUpstreamModule))

{% highlight bash %}
##################################
# https://staging.wzuup.com

upstream mongrel_staging {
  server 127.0.0.1:8000;
  server 127.0.0.1:8001;
}

server {
  listen               443;
  ssl                  on;
  ssl_certificate      wzuup.crt;
  ssl_certificate_key  wzuup.key;

  server_name  staging.wzuup.com staging.blindgaenger.net;
  root   /var/rails/wzuup/public;
  access_log  logs/staging.access.log;

  auth_basic            "Wzuup Staging";
  auth_basic_user_file  htpasswd;

  # this rewrites all the requests to the maintenance.html
  # page if it exists in the doc root. This is for capistrano's
  # disable web task
  if (-f $document_root/maintenance.html){
    rewrite  ^(.*)$  /maintenance.html last;
    break;
  }

  location / {
    proxy_set_header  X-Real-IP  $remote_addr;
    proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header  X_FORWARDED_PROTO https;
    proxy_set_header Host $http_host;
    proxy_redirect false;
    if (-f $request_filename/index.html) {
      rewrite (.*) $1/index.html break;
    }
    if (-f $request_filename.html) {
      rewrite (.*) $1.html break;
    }
    if (!-f $request_filename) {
      proxy_pass http://mongrel_staging;
      break;
    }
  }

  index  index.html index.htm;
  error_page   500 502 503 504  /50x.html;
  location = /50x.html {
    root   html;
  }
}
{% endhighlight %}

# Subversion

Unfortunately Nginx can not be used to fully serve a SVN repository, because the
dav module doesn't support PROPFIND (see [http://www.ruby-forum.com/topic/140841](http://www.ruby-forum.com/topic/140841)).
So currently the best way is to use Apache for SVN and serve it via Nginx.

{% highlight bash %}
##################################
# https://svn.wzuup.com/

server {
  listen               443;
  ssl                  on;
  ssl_certificate      wzuup.crt;
  ssl_certificate_key  wzuup.key;

  server_name  svn.wzuup.com;
  access_log   logs/svn.access.log;

  auth_basic    "Wzuup Subversion";
  auth_basic_user_file  htpasswd;

  location /wzuup {
    proxy_pass      http://127.0.0.1:9000;

    if ($http_destination ~ "^http://(.+)") {
      rewrite  ^(.*)$  https://$1 permanent;
    }

    proxy_set_header  X-Real-IP  $remote_addr;
    proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header  X_FORWARDED_PROTO https;
    proxy_set_header Host $http_host;
    proxy_redirect false;
  }
}
{% endhighlight %}


Done!


