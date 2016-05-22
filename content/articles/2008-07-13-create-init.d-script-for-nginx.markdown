---
title: Create init.d script for Nginx
tags:
- wzuup
- nginx
---

Copy the attached file attachment:nginx.init.d where it belongs
{{bash
$ sudo cp nginx.init.d /etc/init.d/nginx
$ sudo chmod +x /etc/init.d/nginx
}}

Add it to the default run levels.
{{bash
$ sudo /usr/sbin/update-rc.d -f nginx defaults
Adding system startup for /etc/init.d/nginx ...
   /etc/rc0.d/K20nginx -> ../init.d/nginx
   /etc/rc1.d/K20nginx -> ../init.d/nginx
   /etc/rc6.d/K20nginx -> ../init.d/nginx
   /etc/rc2.d/S20nginx -> ../init.d/nginx
   /etc/rc3.d/S20nginx -> ../init.d/nginx
   /etc/rc4.d/S20nginx -> ../init.d/nginx
   /etc/rc5.d/S20nginx -> ../init.d/nginx
}}

Start Server
{{bash
$ sudo /etc/init.d/nginx start
Starting nginx: nginx.
}}

Restart server
Works only if the server is already running
{{bash
$ sudo /etc/init.d/nginx restart
Restarting nginx: nginx.
}}

Reload configuration
{{bash
$ sudo /etc/init.d/nginx reload
Reloading nginx configuration: nginx.
}}

Stop server
{{bash
$ sudo /etc/init.d/nginx stop
Stopping nginx: nginx.
}}

# Links

* [Ubuntu LTS - adding an nginx init script](http://articles.slicehost.com/2007/10/17/ubuntu-lts-adding-an-nginx-init-script)

