---
layout: post
title: Internal Framework Plans — Odysseus Development Blog
posttitle: Planning internal Trait Framework
header: 26th December 2017 — Adrian Cochrane
date: 2017-12-26 16:52:38 1300
categories: features
---

While I wait for Odysseus to be accepted into the AppCenter (which is probably understandably slow during the Holiday season), I thought it might be nice to lay out a short-term roadmap for an internal framework to develop longer-term (though very important) browser features on. 

## Where Am I Now on this?

I already have the start of an internal framework for traits, as they have been a crucial help in delivering the traits I've already developed. Specifically this framework consists of:

* Loose coupling between the addressbar and it's "autocompleters".
* A templating language "[Prosody](https://alcinnz.github.io/Odysseus/architecture/2017/07/22/prosody.html)" for rendering internal `odysseus:` pages. 
* An [SQLite](https://sqlite.org/) database that's already actively used for persisting browsing sessions.
* An initializer for "traits" and "services", capable of registering handlers for webpage loading, autocompletions, and more.

Notably the templating language so far has only been useful to aid more internationalization and to render the viewsource page. But it's trivial to see it'll be vital to later developments and for whenever I find a way to render my own error pages without overwriting those of sites like GitHub that don't specify ahead of time the filesize of those error messages.

## What Do I Want To Add to This?

In large part I want to be able to make greater use of Odysseus's database from internal pages:

* Be able to run [queries](http://www.sqltutorial.org/) against the database from Prosody and render the results to a webpage.
* Be able to [update the database using forms](https://msdn.microsoft.com/en-us/library/dd203052.aspx) in the internal pages.
* Easy definition of autocompleters using pure SQL.

But also I want a more intelligent addressbar which stretches a bit beyond the native [Gtk.Entry](https://valadoc.org/gtk+-3.0/Gtk.Entry.html) control to allow:

* Togglable icons to be added to the right-hand-side mostly for "installing" declarative extensions.
* Rounded boxed "[tokens](http://loopj.com/jquery-tokeninput/)" to be added before the text entry for searching history and bookmarks. Also useful for a tagging control.

Then to allow fast detection of whether to show particular icons, I want "services" to make it fast to trigger the presentation of icons upon certain:

* (alternative) MIMEtypes
* RDF predicates

Once the data is lexed by a [Vala](https://valadoc.org/glib-2.0/GLib.MarkupParser.html) [library](https://valadoc.org/raptor/Raptor.html), a simple [HashMap](https://valadoc.org/gee-0.8/Gee.HashMap.html) should help prevent [any slowdown](https://webkit.org/blog/6/hashtables-part-1/) whatsoever (that is no matter how many MIMEtypes or RDF predicates I test for, the performance would remain the same). Particularly if I can do these tasks [on idle](https://valadoc.org/glib-2.0/GLib.Idle.add.html).

### Browser Extensions

I am very hesitent to support browser extensions, because as they are implemented in the mainstream browsers they mostly serve to slow the browser down whilst cluttering their toolbars. However as I move towards helping my surfers to find webpages to visit, it'll become hard for me to do so without utilizing arbitrary third-party datasources. These datasources would amount to a type of browser plugin, one I (and WebKit) can optimize better whilst having enough control of their UI to make them invisible navigation aids. 

Currently I plan to support to support the following types of extensions:

* Search engines -- with both [l](https://ddg.gg/)[e](https://google.com/)[g](https://bing.com/)acy and [OpenSearch](http://www.opensearch.org/Home) [flavours](https://www.geonetwork-opensource.org/) I can combine into one search page, these plugins are important to help users research known topics (for some loose definition of research).
* Vocabularies -- used with bookmarks to encourage more consistancy between websites and surfers. Uses [SKOS](https://www.w3.org/2004/02/skos/) and while they would help to avoid "[shit work](http://zachholman.com/posts/shit-work/)", they would also be particularly helpful for sharing bookmarks. 
* Share links -- added to a menu accessible through right/hold-click on favourites.
* [Content blockers](https://webkit.org/blog/3476/content-blockers-first-look/), [userscripts](https://openuserjs.org/about/Userscript-Beginners-HOWTO), [userstyles](https://github.com/stylish-userstyles/stylish/wiki) -- types of extensions built-in to WebKit that'll be exposed through Odysseus. 

Notably, (almost) all of these extensions correspond to existing standards with the exception being content blockers. But that's an existing format from Apple that's already in use. Furthermore, for simplicity, these would be installed during the course of normal browsing through icons in the addressbar. Upon install, a [toast](https://valadoc.org/granite/Granite.Widgets.Toast.html) overlay would confirm successfully install and, to support AppCenter-style [pay-what-you-want](https://www.humblebundle.com/)/[koha](https://en.wikipedia.org/wiki/Koha_(custom)) payment models, include a button linking to a donation page if it can find one. To do so it would like for a link with a [rel=payment](http://relpayment.com/), which in turn is another existing "microdata" standard. 
