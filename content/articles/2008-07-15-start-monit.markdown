---
title: Start Monit
tags:
- wzuup
- monit
---

Start monit in interactive mode.
{{bash
$ vs184010:~# monit -I
Starting monit daemon with http interface at [localhost:2812]
Starting monit HTTP server at [localhost:2812]
monit HTTP server started
Monit started
}}

To stop press `CTRL+C`
{{bash
Shutting down monit HTTP server
monit HTTP server stopped
monit daemon with pid [21987] killed
Monit stopped
$
}}

Inspect the log at `/var/log/monit`
{{bash
$ less /var/log/monit
[UTC Jul 19 13:29:29] info     : Starting monit daemon with http interface at [localhost:7000]
[UTC Jul 19 13:29:29] info     : Starting monit HTTP server at [localhost:7000]
[UTC Jul 19 13:29:29] info     : monit HTTP server started
[UTC Jul 19 13:29:29] info     : Monit started
[UTC Jul 19 13:30:29] info     : Monit has not changed
[UTC Jul 19 13:37:10] info     : Shutting down monit HTTP server
[UTC Jul 19 13:37:10] info     : monit HTTP server stopped
[UTC Jul 19 13:37:10] info     : monit daemon with pid [15731] killed
[UTC Jul 19 13:37:10] info     : Monit stopped
}}

# Notes

Another way is to start monit in the background.
{{bash
$ monit
}}

But to stop it, you need to kill it.
{{bash
$ kill `cat /var/run/monit.pid`
}}
