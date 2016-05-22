---
title: Compile Nginx
tags:
- wzuup
- nginx
---

Download and unzip the sources.
{{bash
$ cd /tmp
$ wget http://sysoev.ru/nginx/nginx-0.7.6.tar.gz
$ tar -xzvf nginx-0.7.6.tar.gz 
$ cd nginx-0.7.6/
}}

Make sure the OpenSSL is available, needed for `--with-http_ssl_module`
{{bash
$ sudo apt-get install libssl-dev
}}

Configure with SSL and WebDAV module enabled
<http://wiki.codemongers.com/NginxInstallOptions>
{{bash
$ ./configure --with-http_ssl_module --with-http_dav_module
...
Configuration summary
  + using system PCRE library
  + using system OpenSSL library
  + md5 library is not used
  + sha1 library is not used
  + using system zlib library
  
  nginx path prefix: "/usr/local/nginx"
  nginx binary file: "/usr/local/nginx/sbin/nginx"
  nginx configuration prefix: "/usr/local/nginx/conf"
  nginx configuration file: "/usr/local/nginx/conf/nginx.conf"
  nginx pid file: "/usr/local/nginx/logs/nginx.pid"
  nginx error log file: "/usr/local/nginx/logs/error.log"
  nginx http access log file: "/usr/local/nginx/logs/access.log"
  nginx http client request body temporary files: "/usr/local/nginx/client_body_temp"
  nginx http proxy temporary files: "/usr/local/nginx/proxy_temp"
  nginx http fastcgi temporary files: "/usr/local/nginx/fastcgi_temp"
}}

Build and install it.
{{bash
$ make
$ sudo make install
...
}}

Done!

# Modules

* <http://wiki.nginx.org/NginxModules>
* <http://wiki.nginx.org/NginxHttpAuthBasicModule>
* <http://wiki.nginx.org/NginxHttpProxyModule>
* <http://wiki.nginx.org/NginxHttpSslModule>

# Links
* [Ubuntu LTS - installing nginx](http://articles.slicehost.com/2007/10/16/ubuntu-lts-installing-nginx)



