# blindgaenger.net

The personal homepage of my alter ego [blindgaenger](http://blindgaenger.net)!

## GitHub Pages

https://pages.github.com/
https://gohugo.io/tutorials/github-pages-blog/#configure-git-workflow

Add Github pages

    git checkout --orphan gh-pages
    git rm -rf .
    echo "YAY" >index.html
    git add .
    git commit -m "initial gh-pages"
    git push origin gh-pages

Check out

    open https://blindgaenger.github.io/blindgaenger-homepage/

Remove `public` dir

    git checkout master
    rm -rf public
    git add .
    git commit -m "removed public dir"
    git push origin master

Add `public` dir from gh-pages

    git fetch --all
    git subtree add --prefix=public git@github.com:blindgaenger/blindgaenger-homepage.git gh-pages
    git subtree pull --prefix=public git@github.com:blindgaenger/blindgaenger-homepage.git gh-pages

Build project

    make build
    git add --all public
    git commit -m "updated page"
    git push origin master
    git subtree push --prefix=public git@github.com:blindgaenger/blindgaenger-homepage.git gh-pages

## License

               DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                       Version 2, December 2004

    Copyright (C) 2011 blindgaenger <blindgaenger [at] gmail [dot] com>

    Everyone is permitted to copy and distribute verbatim or modified
    copies of this license document, and changing it is allowed as long
    as the name is changed.

               DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
      TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

     0. You just DO WHAT THE FUCK YOU WANT TO.

## TODO

- RSS feed
  <link href="{{ .RSSlink }}" rel="alternate" type="application/rss+xml" title="{{ .Site.Title }}" />
- enable disqus support
- header images in summary
- structure
  blindgaenger.net/
    articles/
      git commands/
        index.md
