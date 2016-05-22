---
layout: post
title: E-Mail Forwarding from Point to Gmail
tags:
- dns
- email
- alias
- pointhq
- gmail
---

I use [Point](http://pointhq.com/) to manage the DNS of all my domains. Actually I think it's one of the best tools out there. All you've to do is to register the `dnsX.pointhq.com` nameservers at your domain provider and start managing your DNS settings from the easy to use Point interface.

But when I wanted to forward `mail@foobar.com` to my `myname@gmail.com` account, it didn't work. Note it's a standard Gmail account, not Google Apps. Even the [User Manual](http://docs.atechmedia.com/point/user-manual) does not contain a hint, but here's how!

# Point Setup

As I said above the Point's user interface is so easy that it does all the work for you.

- Edit your domain records
- Click `Manage E-Mail Forwarding` on the right
- Confirm and the needed `MX` records will be added
- Click `Add New E-Mail Alias` on the right
- Alias `mail@foobar.com` to `myname@gmail.com`
- Save and done!

# Gmail Setup

Although the example destination in Point mentions some `@gmail.com` address this didn't worked for me out of the box. When I send mails to `mail@foobar.com`, but they didn't appear in my Gmail inbox.

It took me some time to figure out what was wrong: I had to register the mail in Gmail, too.

- Login to your `myname@gmail.com` Gmail account
- Go to `Settings » Accounts and Imports » Send mail as`
- Click `Send mail from another address`
- Enter `mail@foobar.com` as address and send the verification
- You'll get a confirmation mail from `mail@foobar.com` … Yay, first time!
- Use the code to confirm the address
- That's it!

Now you can send mails to `mail@foobar.com` and they appear in your inbox. 

# Note on wildcards

Point allows to set `*` as an alias, but Gmail does not. The catch-all approach is only allowed for Google Apps accounts. Strangely enough you can register `*@foobar.com` in Gmail and happily send mails as and to `*`. So this is just the name and not a wildcard.

What I did, I registered the `*` in Point and registered my needed mail addresses in Gmail. This way I don't have to configure both.