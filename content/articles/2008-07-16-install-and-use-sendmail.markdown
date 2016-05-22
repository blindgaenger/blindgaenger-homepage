---
title: Install and use sendmail
tags:
- wzuup
- sendmail
---

# Install

Install via `apt-get`:
{{bash
$ apt-get install make
$ apt-get install sendmail sendmail-bin
}}

Send a mail from command line with `mail`, which uses `sendmail` for transmission.
Enter mail, end with "." on a line by itself.
{{bash
$ mail you@home.com
Subject: Enter your subject here
And this is the body. End it with a "." on a line by itself.
.
Cc: 
}}

Monitor at the log, which mails have been sent.
{{bash
$ less /var/log/mail.log
...
Jul 19 13:22:48 vs184010 sendmail[8071]: alias database /etc/mail/aliases rebuilt by root
Jul 19 13:22:48 vs184010 sendmail[8071]: /etc/mail/aliases: 13 aliases, longest 10 bytes, 144 bytes total
Jul 19 13:22:49 vs184010 sm-mta[8151]: starting daemon (8.13.8): SMTP+queueing@00:10:00
Jul 19 13:25:45 vs184010 sendmail[21524]: m6JDOqDR021524: from=me@work.com, size=0, class=0, nrcpts=7, relay=root@localhost
Jul 19 13:27:49 vs184010 sm-mta[7402]: starting daemon (8.13.8): SMTP+queueing@00:10:00
Jul 19 13:28:35 vs184010 sm-mta[11380]: m6JDSZoG011380: from=<monit@blindgaenger.net>, size=553, class=0, nrcpts=1, msgid=<1216474115@vs184010.vserver.de>, proto=SMTP, daemon=MTA-v4, relay=localhost.localdomain [127.0.0.1]
Jul 19 13:28:36 vs184010 sm-mta[11383]: m6JDSZoG011380: to=<mail@wzuup.com>, delay=00:00:01, xdelay=00:00:01, mailer=esmtp, pri=120553, relay=gmail-smtp-in.l.google.com. [209.85.129.27], dsn=2.0.0, stat=Sent (OK 1216474116 13si6851157fks.6)
}}

# Start, Restart, Stop

Start
{{bash
$ sudo /etc/init.d/sendmail start
Starting Mail Transport Agent: sendmail.
}}

Restart
{{bash
$ sudo /etc/init.d/sendmail restart
Restarting Transport Agent: sendmail.
}}

Stop
{{bash
$ sudo /etc/init.d/sendmail stop
Stopping Mail Transport Agent: sendmail.
}}

