---
layout: post
title: Advanced Git aliases
tags:
- git
- shell
---

Started with git's commandline, tried some other tools like [git-sh](http://github.com/rtomayko/git-sh/) for a while, I've returned to the core cli. Not because it is so awesome, but `git` has become just another tool for the shell. Which is a good thing!

Nevertheless I use a lot of aliases. So here are some I've created and considered as useful extensions to standard aliases like `git s`. Simply put them in the `[alias]` section of your `~/.gitconfig`. By the way, I've tried not to use aliases in the examples.


# Make *this* a git repo

You do this very often? So don't repeat yourself!

{{  
this = !git init && git add . && git commit -m \"initial commit\"
}}

Example:

{{bash
$ mkdir foobar
$ cd foobar
$ touch README
$ git this
Initialized empty Git repository in /home/blindgaenger/foobar/.git/
[master (root-commit) 77d19af] initial commit
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 README
}}


# Amend with the same message

It's like `git commit --amend`, but without your editor prompting you for the message you've already entered. But remember … "With great power comes great responsibility!"

{{
amend = !git log -n 1 --pretty=tformat:%s%n%n%b | git commit -F - --amend
}}

Example:

{{bash
$ touch foo
$ touch bar
$ git add foo
$ git commit -m "added foo and bar"
$ git add bar
$ git amend
[master 8335e6e] added foo and bar
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 bar
 create mode 100644 foo
}}


# Remove files which have been deleted

Based on a command from [Technical Pickles](http://technicalpickles.com/), I've added correct handling of whitespaces in filenames.

{{
r  = !git ls-files -z --deleted | xargs -0 git rm
}}

Example:
{{bash
$ touch "franz kafka"
$ git add franz\ kafka
$ git commit -m "added franz kafka"
…
$ rm franz\ kafka
$ git r
rm 'franz kafka'
$ git x "deleted it again"
[master 1b993c5] deleted it again
 0 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 you
}}


# Show all defined aliases

You'll need this if you have a lot of aliases. :)

{{
alias = !git config --list | grep 'alias\\.' | sed 's/alias\\.\\([^=]*\\)=\\(.*\\)/\\1\\t=> \\2/' | sort
}}

Example:

{{bash
$ git alias
a       => add .
alias   => !git config --list | grep 'alias\.' | sed 's/alias\.\([^=]*\)=\(.*\)/\1\t=> \2/' | sort
amend   => !git log -n 1 --pretty=tformat:%s%n%n%b | git commit -F - --amend
b       => branch
cb      => checkout -b
co      => checkout
…
}}


# Ignore a file

Quickly add a file/dir to `.gitignore`.

{{
ignore=!([ ! -e .gitignore ] && touch .gitignore) | echo $1 >>.gitignore
}}

Example:

{{bash
$ touch xxx
$ git s
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       xxx
nothing added to commit but untracked files present (use "git add" to track)
$ git ignore xxx
$ git s
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
nothing added to commit but untracked files present (use "git add" to track)
$ git add .gitignore
$ git commit -m "ignored xxx"
}}


# Lil commit

Nothing special, but very useful. The trick is to put the `-m` parameter at the end.

{{
x  = commit -m
xa = commit -a -m
# just to complete this combination
a = add
}}

Example:

{{bash
$ touch baz
$ git add baz
$ git x "added baz"
[master 2d4690b] added baz
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 baz
$ echo "lala" >baz
$ git xa "updated baz"
[master 866f25a] updated baz
 1 files changed, 1 insertions(+), 0 deletions(-)
}}


# Call me master

Not a typical alias, because it gets rid of the verb itself. But useful if you keep feature branches.

{{
master = checkout master
}}


