---
layout: post
title: Generate GitHub pages in a submodule
tags:
- github
- git
- submodule
---

# Create a new project repo

Ok, this is the basic stuff. Go to your [GitHub dashboard](https://github.com/), 
create a new project, and follow the instructions. I've called mine `foobar`.

    {{bash
    mkdir foobar
    cd foobar
    git init
    touch README
    git add README
    git commit -m "initial commit"
    git remote add origin git@github.com:blindgaenger/foobar.git
    git push origin master
    }}

# Create an own branch for the gh-pages

There is a little docu about [GitHub pages](http://pages.github.com/), but
basically you'll need to do the following.

    {{bash
    cd foobar
    git symbolic-ref HEAD refs/heads/gh-pages
    rm .git/index
    git clean -fdx
    echo "Hello, Foobar!" > index.html
    git add .
    git commit -a -m "my first gh-page"
    git push origin gh-pages
    }}

The index.html is just a dummy. But it's necessary to commit something to make
the branch breath. Otherwise you'll have some trouble on the next steps.


# Check page online

Alright, after pushing your files you're ready to check out the generated site
online at <http://blindgaenger.github.com/foobar/>

GitHub says it can take up to ten minutes, but usually it's only about 1 -2
minutes. So wait for a notification email or keep pushing the browser's refresh 
button!


# Add as submodule in master branch

Now there are two separate branches called `master` and `gh-pages`. The next 
step is to reference the `gh-pages` branch to a subdir of `master`. By the way, 
it's not possible to reference a submodule at the root of another branch. But a 
subdir is exactly what we want here.

Further the official Git book warns us about [submodules](http://book.git-scm.com/5_submodules.html):

> NOTE: Do not use local URLs here if you plan to publish your superproject!

That's what we want to do. Our submodule will resolve to our hosted project at
github (not to some local dir). Let's add the submodule and "mount" it to `_site`.

    {{bash
    $ git checkout master
    $ git submodule add -b gh-pages git@github.com:blindgaenger/foobar.git _site
    $ git status
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #    new file:   .gitmodules
    #    new file:   _site
    #
    $ git commit -m "added gh-pages as submodule"
    $ git push
    }}

The `git status` shows a new `.gitmodules` file, which stores informations about
the submodules. And of course the `_site` directory we specified.

Now init the submodule and check out which revision it points to.

    {{bash
    $ git submodule init
    Submodule '_site' (git@github.com:blindgaenger/foobar.git) registered for path '_site'
    $ git submodule 
     509dbc55199d7efb6fbb4180bc898a0c5b6830de _site (heads/gh-pages)
    }}


# Build a website using Jekyll

At best you reed the [Jekyll wiki](http://wiki.github.com/mojombo/jekyll). But
to get you started, let's create some dummy files. At first put this in a
`index.markdown` file

    {{markdown
    ---
    layout: default
    title: Foobar page
    ---

    # Text

    foo foo foo foo foo foo foo foo.

    bar bar bar bar bar bar bar bar.

    # List

    * foo
    * bar
    * baz
    }}


Now create a `_layouts` directory and a `default.html` file in it. It's a basic 
HTML file. Please note, that it's just an example here!

    {{
    <html>
      <head>
        <title>{{ page.title }}</title>
      </head>
      <body>
        <h1>{{ page.title }}</h1>
        {{ content }}
      </body>
    </html>
    }}

What will happen? At first the `index.markdown` is parsed. The `layout:` 
specification on top will search for a file called `_layout/default.html`, which
we've just created. Then the layout file will be filled with `title` and 
`content` of the page. Note that you can put any variable in the header section
and use it in your layout as `{{ page.lala }}`.

Of course, don't forget to commit your changes.
  
    {{bash
    $ git status
    # On branch master
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #    _layouts/
    #    index.markdown
    #
    $ git add .
    $ git commit -m "some example files"
    }}


# Generate it in our subdir

To generate the website we just have to call `jekyll` in our project dir. This
will put the generated files straight to the `_site` dir, which is the default.
See the jekyll website what this `_config.yml` is all about.

    {{bash
    $ jekyll
    WARNING: Could not read configuration. Using defaults (and options).
        No such file or directory - ./_config.yml
    Building site: . -> ./_site
    Successfully generated site: . -> ./_site
    }}

Now take a look in `_site` and you'll see the `index.html` (we added in our 
first commit to the `gh-pages` branch) has changed to this:

{{
<html>
  <head>
    <title>Foobar page</title>
  </head>
  <body>
    <h1>Foobar page</h1>

    <h2 id='text'>Text</h1>

    <p>foo foo foo foo foo foo foo foo.</p>

    <p>bar bar bar bar bar bar bar bar.</p>

    <h2 id='list'>List</h1>

    <ul>
      <li>foo</li>
      <li>bar</li>
      <li>baz</li>
    </ul>
  </body>
</html>
}}

Great, this is what we expected!


# Where are my changes?

If you now check the status, you'll see no changed files. Why? Because all 
changed content `_site` is seen as changed for the submodule, not for the master
branch. So `cd` to `_site` and repeat it there:

    {{bash
    $ git status
    $ cd _site
    $ git status
    }}

This is what we expected to see. Now add, commit and push `_site`. Note we only
push the `gh-pages`.

    {{bash
    $ cd _site
    $ git add .
    $ git commit -m "site generated"
    $ git push origin gh-pages
    }}

Now go back to the project's root dir, and you'll see that `_site` has changed.
That's right! Because the submodule has been commited in the previous step.
So let's tell the `master` branch, that it should use exactly this revision.
    
    {{bash
    $ git commit -a -m "build site"
    $ git push origin master
    }}

Now both branches should be pushed to github and master `_site` points to the up 
to date `gh-pages`.


# Regeneration of site

This is just a starting point. Of course you want to work with it, here is a 
short list of the steps you're likely to perform.

* Edit some file (e.g. index.markdown).
* run `jekyll` to regenerate
* check if in `_site` is what you want
* add, commit and push changes **in** `_site` subdirectory
* add, commit and push changes **in the project** (including `_site` subdir)
* do it again!

One note about Jekyll's build-in options. When editing your sources it's very 
useful to run a local server. This command will auto-regenerate the site on each
edit and show them via the local server at `http://localhost:4567`.

    {{bash
    jekyll --auto --server 4567
    }}

That's it!

