---
title: Setup Redmine
tags:
- wzuup
- redmine
---

Create database and user.
{{sql
CREATE DATABASE IF NOT EXISTS redmine character SET utf8;
GRANT ALL PRIVILEGES ON redmine.*
  TO "redmine_username"@"localhost" 
  IDENTIFIED BY "redmine_password";
}}

Make sure the native MySQL driver is installed.
Otherwise the application will fail to serve requests.
{{bash
$ sudo gem install mysql
}}

It's necessary to set 'encoding' and 'socket' in database.yml.
{{yaml
production:
  adapter: mysql
  database: redmine
  host: localhost
  username: redmine_username
  password: redmine_password
  encoding: utf8
  socket: /var/run/mysqld/mysqld.sock
}}

Create schema in database.
{{bash
$ rake db:migrate RAILS_ENV="production"
}}

Load some default data in the database.
{{bash
$ rake redmine:load_default_data RAILS_ENV="production"
}}

Change user and privileges.
{{bash
$ sudo chown -R redmine:redmine files log tmp
$ sudo chmod -R 755 files log tmp
}}

Setup mongrel.
*Important:* Check the port, here it's 8010!
{{bash
$ mongrel_rails cluster::configure -a 127.0.0.1 -p 8010 -N 1 -e production -c /var/rails/redmine 
}}

Login the first time.
* username: admin
* password: admin

Done.
