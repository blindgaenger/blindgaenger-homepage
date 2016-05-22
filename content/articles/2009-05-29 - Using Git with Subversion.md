---
layout: post
title: Using Git with Subversion
tags:
- git
- svn
---

Checkout the SVN repository in standard layout (trunk/, branches/, tags/) using -s.

    git svn clone -s https://192.168.117.216/repository/cooceo/cooceo-search
    cd cooceo-search

Cleanup unnecessary files and optimize the local repository (recommended).

    git gc --aggressive

Copy svn:ignore to git, so both repos ignore the same files.

* as an own file you can track, but need to commit it to the SVN repo

    git svn show-ignore > .gitignore

* ignore it in your local GIT repo

    git svn show-ignore >> .git/info/exclude

    git svn show-ignore > .gitignore
    echo '.gitignore' >> .git/info/exclude

Create a feature branch (so master is used for SVN commits)

    git checkout -b new_branch_name [old_branch_name]

Use GIT as usual

  git status
  git add .
  git rm $(git ls-files --deleted)  
  git commit -m <message>
  git checkout <filename>
  git reset HEAD <filename>

Squash multiple GIT commits into one SVN commit

    git checkout master
    git merge --squash <feature_branch>

Update from the SVN repo

    git svn rebase

Commit the changes from GIT to SVN repo

    git svn dcommit

Repeat the last two commands as often as you like.

