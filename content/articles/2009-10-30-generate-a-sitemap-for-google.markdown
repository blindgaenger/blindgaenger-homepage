---
layout: post
title: Generate a sitemap for Google
tags:
- blog
- haml
- sitemap
---

Alright, I thought it would be a good idea to add a sitemap to this blog. Actually 
I don't know if this makes any difference for such a small site. But it won't hurt!


# Generate a sitemap

My first attempt to generate a sitemap was to google for ["generate sitemap"](http://www.google.com/search?hl=en&ie=UTF-8&oe=UTF-8&q=%22generate+sitemap%22). And guess what, the first 
search result is a [XML Sitemaps Generator](http://www.xml-sitemaps.com/). No
registration, a prompting input field for the URL, nothing to lose … So let's try it!

Of course, the free service is limited, but it is enough to get a first 
impression about what sitemaps are all about.

Enter the URL of your blog, defaults for *change frequency* and *modification date*
are fine. A little interesting is the *automatic priority calculation*, so switch 
it on and press start. After a while the results are downloadable in various 
formats. But you can ignore all except the `sitemap.xml` file.


# ROR is not RoR

Before we examine the `sitemap.xml`, there is another file called `ror.xml`. 
Obviously it has nothing to do with Ruby on Rails. Anyway I've never heard about 
this format before, but it looked like this:

{{
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:ror="http://rorweb.com/0.1/" >
<channel>
  <title>ROR Sitemap for http://blog.blindgaenger.net/</title>
  <link>http://blog.blindgaenger.net/</link>
  <item>
       <link>http://blog.blindgaenger.net/</link>
       <title>when you don't know where you @ &mdash; blindgaenger</title>
       <ror:updatePeriod></ror:updatePeriod>
       <ror:sortOrder>0</ror:sortOrder>
       <ror:resourceOf>sitemap</ror:resourceOf>
  </item>
…
}}

Alright, it's an application of RSS feeds. Note the `ror` namespace extension 
for <http://rorweb.com> and the prefixed elements below. Unfortunately rorweb.com 
seems to have some problems and couldn't be resolved. But it turns out ROR stands 
for *Resources Of a Resource* and basically provides the same functionality as 
we'll find in 'sitemap.xml`. 

Don't know if it is mature enough. Let's see if they fix the homepage and ROR 
makes it to version `0.2`. :)


# Examine the sitemap XML

My generated sitemap looked something like this:

{{
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>http://blog.blindgaenger.net/</loc>
    <lastmod>2009-10-19T17:30:55+00:00</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.00</priority>
  </url>
  <url>
    <loc>http://blog.blindgaenger.net/archives/</loc>
    <lastmod>2009-10-19T17:30:55+00:00</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.80</priority>
  </url>
  <url>
    <loc>http://blog.blindgaenger.net/tags/</loc>
    <lastmod>2009-10-19T17:30:55+00:00</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.80</priority>
  </url>
  <url>
    <loc>http://blog.blindgaenger.net/emacs_stuff.html</loc>
    <lastmod>2009-10-19T17:30:55+00:00</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.80</priority>
  </url>
  …
}}

Straight forward! A list of all pages and subpages on my blog's website. Note, 
there is a pretty good explanation of all XML elements and more details 
(like validation) at <http://www.sitemaps.org/protocol.php>. Don't miss it!

`loc` contains the url and is the only required element. You should specify full 
not relative URLs.

`lastmod` is optional, but recommended. For blog posts the date should reflect 
when they were edited.

Now to the more interesting elements `changefreq` and `priority`. It is said,
that these values have nothing to do with your Google's page ranks or crawling. 
But obiously there is no *clear/true/hard/unambiguous* value you can set. So 
there is some room for magic and speculations.

`changefreq` how often the page is subject to change (`always`, `hourly`, 
`daily`, `weekly`, `monthly`, `yearly`, and `never`). I don't write very often, 
so I was honest and set `changefreq` to `weekly`. Archived posts will be set to 
`monthly` as I update old posts quite constantly.

`priority` is a value from 0 to 1.0 (default is 0.5). But who wants to depreciate
his own pages without a reason. Therefore I chose priorities beteen 0.5 and 1.0.
Not very reasonable, I know!


# Build the HAML template

Let's put it together. If you already know HAML this is the easiest part. 
Otherwise take some minutes to check out the introduction on the 
[HAML homepage](http://haml-lang.com/).

{{
!!! XML
%urlset{ :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" }

  - ["", "archives/", "tags/"].each_with_index do |url, index|
    %url
      %loc= "http://blog.blindgaenger.net/#{url}"
      %lastmod= Time.now.xmlschema
      %changefreq weekly
      %priority= (index == 0) ? "1.0" : "0.5"

  - posts.each_with_index do |post, index|
    %url
      %loc= post.url
      %lastmod= post.date.xmlschema
      %changefreq monthly
      %priority= post.priority || (index < 5 ? "0.8" : "0.6")
}}
    
I've added two loops, one for pages and one for posts. The pages don't have an 
own timestamp, so the `lastmod` is when they are generated (resp. now).

Of course, the homepage's priority it `1.0` as it's the entry point of the blog.
All other static pages get the default of `0.5`, because they don't have real 
content. They are just containers for links, not the results Google likes.

Next, the first 5 posts get a bonus priority of `0.8`. The summary of these pages
are featured on the homepage, so they are important in a kind of way. All other
posts get a `0.60` to distinguish them from archives and tags.

I don't know anything about your setup, but in the end (and with some custom 
scripts) my sitemap gets generated at <http://blog.blindgaenger.net/sitemap.xml>.
For Rails or Sinatra this should not be so complicated as I did it.


# Submit your sitemap to Google

Alright, now you have a `sitemap.xml` online, but Google doesn't know about it.
Let's tell 'em!

The first step is to register for [Google Webmaster Tools](http://www.google.com/webmasters/tools)
and login. Now `Add a site`, which is <http://blog.blindgaenger.net/> in my case.
But now Google wants us to verify me as the owner of the site. Security is important,
so let's do this.

You can verify via a META tag or a file upload (BTW: same for Yahoo). I took the 
file upload, because it's easier to setup and I don't have to redeploy the 
application when I want to delete it again. All you have to do is to copy the 
`googlexxxxxxxxxxxxx.html` file to your server, press the Verify button and you're
done.

Ok, finally about our sitemap! Now Google knows who you are and you can submit 
your sitemap (resp. a link to it not the XML content). In the Webmaster Tools you'll
find the `Submit a Sitemap` button. Doing so will show you a `Pending download...`
in the status column. It’s merely a matter of time, when it gets downloaded and
parsed.

That's it, you're done. But keep in mind, only the [SEO](http://en.wikipedia.org/wiki/Search_engine_optimization) gods can tell you if a sitemap makes any difference! :)

