---
title: Configure Mongrel cluster for Rails
tags:
- wzuup
- mongrel
---
Go to the rails app directory.
{{bash
$ cd /var/rails/wzuup
}}

Configure the mongrel cluster for this rails app.
{{bash
$ mongrel_rails cluster::configure -a 127.0.0.1 -p 8000 -N 1 -e production -c /var/rails/wzuup 
Writing configuration file to config/mongrel_cluster.yml.
}}

If server should run under `www.example.com/wzuup`. The new `--prefix $APP_ROOT`
command allows Mongrel Applications to properly _ignore_ the prefix. Prior to 
this enhancement, the web server (not mongrel) needed to be configured to strip 
out the prefix.
{{bash
$ mongrel_rails cluster::configure -e production -p 8000 -N 2 -c /var/rails/wzuup -a 127.0.0.1 --prefix /wzuup
}}

The syntax is very easy to understand.
* listen to localhost only
  `-a 127.0.0.1`
* use port 8000
  `-p 8000`
* start only one mongrel server
  *Important:* for `N=3` three servers with ports 8000, 8001 and 8002 will be used
  `-N 1`
* run the rails app in the production environment
  `-e production`
* the root of the rails app
  `-c /var/rails/wzuup`

Start the mongrel cluster
{{bash
$ mongrel_rails cluster::start
starting port 8000
}}

Check if mongrel servers are running
{{bash
$ ps ax | grep mongrel
 6836 ?        Sl     0:01 /usr/bin/ruby1.8 /usr/bin/mongrel_rails start -d -e production -a 127.0.0.1 -c /var/rails/wzuup -p 8000 -P tmp/pids/mongrel.8000.pid -l log/mongrel.8000.log
 6844 pts/0    R+     0:00 grep mongrel
}}

Stop the mongrel cluster
{{bash
$ mongrel_rails cluster::stop
stopping port 8000
}}


