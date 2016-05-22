---
title: Install MySQL and native MySQL driver for Ruby
tags:
- wzuup
- mysql
---

# MySQL Installation

Linux is pretty straight forward, so install with `apt-get` as usual.
{{bash
$ sudo apt-get install mysql mysql-client mysql-server
}}

For the developers on Windows, go to the [MySQL Homepage](http://dev.mysql.com/downloads/mysql/5.0.html).
Scroll down to `Windows downloads` and download the `Windows ZIP/Setup.EXE (x86)` file.

Follow the setup instructions.

# Building native MySQL driver for Ruby

It's much faster and more secure to use a native database driver to MySQL. 
Otherwise Ruby will use its internal default driver.

So install the Ruby binding for MySQL Server:
{{bash
$ sudo apt-get install libmysql-ruby
Reading Package Lists... Done
Building Dependency Tree... Done
0 upgraded, 0 newly installed, 1 reinstalled, 0 to remove and 50 not upgraded.
Need to get 0B/4984B of archives.
After unpacking 0B of additional disk space will be used.
Do you want to continue? [Y/n] 
(Reading database ... 40083 files and directories currently installed.)
Preparing to replace libmysql-ruby 2.7.1-1 (using .../libmysql-ruby_2.7.1-1_all.deb) ...
Unpacking replacement libmysql-ruby ...
Setting up libmysql-ruby (2.7.1-1) ...
}}

Now try to install the gem for the mysql driver. It builds the native driver 
against the MySQL binding.

If you miss the packages you may see something like this:
{{bash
$ sudo gem install mysql
Building native extensions.  This could take a while...
ERROR:  Error installing mysql:
    ERROR: Failed to build gem native extension.

/usr/local/bin/ruby extconf.rb install mysql
checking for mysql_query() in -lmysqlclient... no
checking for main() in -lm... yes
checking for mysql_query() in -lmysqlclient... no
checking for main() in -lz... yes
checking for mysql_query() in -lmysqlclient... no
checking for main() in -lsocket... no
checking for mysql_query() in -lmysqlclient... no
checking for main() in -lnsl... yes
checking for mysql_query() in -lmysqlclient... no
* extconf.rb failed *
Could not create Makefile due to some reason, probably lack of
necessary libraries and/or headers.  Check the mkmf.log file for more
details.  You may need configuration options.

Provided configuration options:
    --with-opt-dir
    --without-opt-dir
    …
    --without-mysqlclientlib

Gem files will remain installed in /usr/local/lib/ruby/gems/1.8/gems/mysql-2.7 for inspection.
Results logged to /usr/local/lib/ruby/gems/1.8/gems/mysql-2.7/gem_make.out
}}

If the error above occures, you need to install the development packages, too.
{{bash
$ sudo apt-get install libmysqlclient15-dev
}}

Now the mysql gem should work and the native driver is available. It's 
automatically used as default MySQL driver, for example in all rails apps.
{{bash
$ sudo gem install mysql
Building native extensions.  This could take a while...
Successfully installed mysql-2.7
1 gem installed
}}

