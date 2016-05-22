---
title: Monitor applications with Monit
tags:
- wzuup
- monit
---

# SSH

[HowTo: monit unter Debian Etch](https://www.adminlife.net/admins-helferlein/howto-monit-unter-debian-etch/)
{{bash
check process sshd with pidfile /var/run/sshd.pid
start program = "/etc/init.d/ssh start"
stop  program = "/etc/init.d/ssh stop"
if failed port 22 protocol ssh then restart
if 5 restarts within 5 cycles then timeout
}}

# Apache

<http://mmonit.com/wiki/Monit/ConfigurationExamples#apache>

*Hint:* It is recommended to use a "token" file (an empty file) for monit to 
request. That way, it is easy to filter out all the requests made by monit in 
the httpd access log file. Here's a trick shared by Marco Ermini, place the 
following in httpd.conf to stop apache from loggin any requests done by monit:
{{bash
  SetEnvIf        Request_URI "^\/monit\/token$" dontlog
  CustomLog       logs/access.log common env=!dontlog
}}

In some cases init scripts for apache and apache-ssl are separated (e.g. Debian Linux).
{{bash
 check process apache with pidfile /opt/apache_misc/logs/httpd.pid
   group www
   start program = "/etc/init.d/apache start"
   stop  program = "/etc/init.d/apache stop"
   if failed host 192.168.1.1 port 80 
        protocol HTTP request /monit/token then restart
   if failed host 192.168.1.1 port 443 type TCPSSL 
        certmd5 12-34-56-78-90-AB-CD-EF-12-34-56-78-90-AB-CD-EF
      protocol HTTP request /monit/token  then restart
   if 5 restarts within 5 cycles then timeout
   depends on apache_bin
   depends on apache_rc

 check file apache_bin with path /opt/apache/bin/httpd
   group www
   if failed checksum then unmonitor
   if failed permission 755 then unmonitor
   if failed uid root then unmonitor
   if failed gid root then unmonitor

 check file apache_rc with path /etc/init.d/apache
   group www
   if failed checksum then unmonitor
   if failed permission 755 then unmonitor
   if failed uid root then unmonitor
   if failed gid root then unmonitor
}}

# Mongrel

[This little snippet](http://www.igvita.com/2006/11/07/monit-makes-mongrel-play-nice/)
was posted by the (let's say all-round guru) [Ilya Grigorik](http://www.igvita.com/).

{{bash
##### mongrel 8010 #####
check process mongrel-8010 with pidfile /home/user/rails/current/log/mongrel.8010.pid
    start program = "/usr/local/bin/ruby /usr/local/bin/mongrel_rails start -d -e production -p 8010 -a 127.0.0.1 -P /home/user/current/log/mongrel.8010.pid -c /home/user/rails/current"
    stop program  = "/usr/local/bin/ruby /usr/local/bin/mongrel_rails stop -P /home/user/current/log/mongrel.8010.pid"

    if totalmem is greater than 60.0 MB for 5 cycles then restart       # eating up memory?
    if cpu is greater than 50% for 2 cycles then alert                  # send an email to admin
    if cpu is greater than 80% for 3 cycles then restart                # hung process?
    if loadavg(5min) greater than 10 for 8 cycles then restart          # bad, bad, bad
    if 3 restarts within 5 cycles then timeout                         # something is wrong, call the sys-admin

    if failed port 8010 protocol http                   # check for response
        with timeout 10 seconds
        then restart
    group mongrel
}}


