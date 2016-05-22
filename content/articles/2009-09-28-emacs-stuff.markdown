---
layout: post
title: Emacs stuff
tags:
- emacs
- setup
---

Yep, I think almost every developer out there has a _try Emacs_ todo on their
list. All others seems to already use it for decades. In the ruby community 
people like defunkt caused a little renaissance, but I might be wrong and this 
is my very own impression.

Anyway, I've installed Emacs several times (even before GitHub & Co.). But 
honestly I still can't get used to it. Nevertheless its a tool in your box, and 
you should know how to close it at least. Just kidding! :)

Try it yourself. Maybe you'll find something which makes you to switch to Emacs. 
On this page I'm collecting all stuff to learn and pimp my setup. Enjoy!


# Cheat sheet for shortcuts

The problem you have to take care of when learing Emacs is to learn its 
keys/shortcuts. As with for example `vim` its real power is a quick navigation
of all functions under your fingertips. So the first weeks you definitely need a 
[XEmacs Reference Card](http://www.digilife.be/quickreferences/QRC/XEmacs%20Reference%20Card.pdf).
This one may be a little outdated, but very instructable and handy if printed out.


# Useful Links

Some useful sites with instructions, tips and tricks. I've found most of the 
stuff below on these sites.

* [EmacsWiki](http://www.emacswiki.org/)
* [10 Specific Ways to Improve Your Productivity With Emacs](http://steve.yegge.googlepages.com/effective-emacs)
* [emacs-fu - useful tricks for emacs](http://emacs-fu.blogspot.com/)
* [Emacs Starter Kit](http://github.com/technomancy/emacs-starter-kit)


# Add a dark color theme

Just because I like the colors of the [Tango Desktop Project](http://tango.freedesktop.org) 
and a dark background color. The [Emacs Wiki](http://www.emacswiki.org/) gives 
more detailed informations about [Color themes](http://www.emacswiki.org/emacs/ColorTheme)
in general.

But this is how I installed this sweet [color-theme-subdued](http://jblevins.org/projects/emacs-color-themes/)
by Jason Blevins I came across.

* Create a `~/.emacs.d/vendor` directory

* Open or create the `~/.emacs` file and add the dir to `load_path`

  {{cl
  (add-to-list 'load-path "~/.emacs.d/vendor")
  }}

* Download the [color-theme-subdued](http://code.jblevins.org/misc.git/plain/color-theme-subdued.el) file
  
* Move the file in the just created `~/.emacs.d/vendor`

* Load the scheme in your `~/.emacs` file

  {{cl
  ;; default color scheme
  (require 'color-theme-subdued)
    (color-theme-subdued)
  }}


# Map Caps Lock to Control

In Emacs you have to use CTRL for nearly every command. So moving your hand to 
much is very uncomfortable. The solution is to map the (almost) unused CAPS-LOCK 
as a second CTRL key. This is even the no. 1 tip of Steve Yegge's great post 
[10 Specific Ways to Improve Your Productivity With Emacs](http://steve.yegge.googlepages.com/effective-emacs).

After using it a while I even remapped CAPS-LOCK not for Emacs only, but for the
whole OS. Here is an easy description how you can [Map CAPS-LOCK to Control in Ubuntu and Mac OS X](http://devlab.ca/?p=4188&cpage=1).
Without all these neat screenshots in Ubuntu it's quite simple:

* Open the dialog `System » Preferences » Keyboard » Layout Options…`
* Set the radio button `Ctrl key position » Make CapsLock an additional Ctrl`
* Done!


# Highlight the current line

For more options please read [Highlight the Current Line](http://emacsblog.org/2007/04/09/highlight-the-current-line/)
post of the [M-x all-things-emacs](http://emacsblog.org/) blog.

But this is what I put in my `~/.emacs` file:

{{cl
(global-hl-line-mode 1)
(set-face-background 'hl-line "#330")
}}


# Reload .emacs without restarting Emacs

Ok, almost everything is configured in your `~/.emacs` file. And as a beginner
it's quite annoying to edit, save, close, open and find the file again. But 
there's a way on [How to reload your .emacs file while emacs is running](http://www.saltycrane.com/blog/2007/07/how-to-reload-your-emacs-file-while/)

* `M-x load-file` `ENTER`
* `~/.emacs` `ENTER`

More advanced users may add a shortcut for this. It's up to you to find out how. :)


# Use a line instead a block cursor

Block cursors as old-school as CRT displays. Further all commands use the 
beginning of the block cursor (for example delete). Which confused me a little,
because I was used to the line cursors.

But of course you can change everything in Emacs! Again, the Emacs Wiki gives 
instructions how to [Change the Cursor Dynamically](http://www.emacswiki.org/emacs/ChangingCursorDynamically)

* Add this [cursor-chg.el](http://www.emacswiki.org/emacs/download/cursor-chg.el) to your `load-path`.

* Add this to your `~/.emacs` file to require it.

  {{cl
  (require 'cursor-chg)
  (toggle-cursor-type-when-idle -1)
  (change-cursor-mode 1)
  }}


# Add Markdown support

Jason Blevins created a great [Emacs markdown-mode](http://jblevins.org/projects/markdown-mode/).
A must have these days!

* Clone the repository and put the files in your `load-path`:

  {{bash
  git clone git://jblevins.org/git/markdown-mode.git
  }}

* Set `markdown-mode` manually for the current file:

  {{cl
  M-x markdown-mode
  }}

* Register the mode for `md`, `mkdn` and `markdown` files:

  {{cl
  ;; markdown-mode
  (setq auto-mode-alist
     (cons '("\\.md" . markdown-mode) auto-mode-alist))
  (setq auto-mode-alist
     (cons '("\\.mkdn" . markdown-mode) auto-mode-alist))
  (setq auto-mode-alist
     (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
  }}


# Move lines up and down

I got used to moveing lines in Eclipse and Gedit. Actually I can't handle my 
TODO lists without these shortcuts anymore! This is the 
[Move Line](http://www.emacswiki.org/emacs/MoveLine) script by Joe Smith. 
Basically it maps some global keys to the `move-line` function. Nice!

{{cl
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
}}

