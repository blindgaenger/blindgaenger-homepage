---
title: Setup MySQL database for Rails
tags:
- wzuup
- mysql
---
Login to the MySQL instance.
{{bash
$ sudo mysql -uroot -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 174
Server version: 5.0.32-Debian_7etch5-log Debian etch distribution

Type 'help;' or '\h' for help. Type '\c' to clear the buffer.

mysql>
}}

Create the database for the rails app.
{{bash
mysql> CREATE DATABASE IF NOT EXISTS wzuup_production;
}}

Create a user and give him a password.
{{bash
mysql> GRANT ALL PRIVILEGES ON wzuup_production.*
    -> TO "wzuup_username"@"localhost" 
    -> IDENTIFIED BY "wzuup_password";
}}

Type _quit_ or press CTRL+D to quit MySQL.
{{bash
mysql> quit
Bye
}}

Change the RAILS_PROJECT/config/attachment:database.yml to have the same user and password as in the SQL statement above.
{{bash
production:
  adapter: mysql
  encoding: utf8
  database: wzuup_production
  username: wzuup_username
  password: wzuup_password
  socket: /var/run/mysqld/mysqld.sock
}}

Create the schema in the created database using the migrations.

*Important:* Set the environment to production!
{{bash
$ rake RAILS_ENV=production db:migrate
}}

