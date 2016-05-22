---
title: Configure Monit
tags:
- wzuup
- monit
---

Monit is configured by `~/.monitrc` which needs to be created after installation.
{{bash
$ vim .monitrc
}}

Create a minimal control file.
{{bash
# check every 60sec
set daemon 60

# configure the notification on alert
set mailserver localhost
set mail-format { from: monit@blindgaenger.net }
set alert blindgaenger@gmail.com

set httpd port 2812 and
    use address localhost  # only accept connection from localhost
    allow localhost        # allow localhost to connect to the server and
}}

Run syntax check for the control file.
{{bash
$ monit -t
monit: The control file '/root/.monitrc' must have permissions no more than -rwx------ (0700); right now permissions are -rw-r--r-- (0644).
}}

Change the permissions and recheck
{{bash
$ chmod 0700 .monitrc
$ monit -t
Control file syntax OK
}}


