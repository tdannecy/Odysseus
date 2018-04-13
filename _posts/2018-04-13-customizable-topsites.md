---
layout: post
title: Customizable Topsites — Odysseus Development Blog
posttitle: Customizable Topsites on odysseus:home
header: 13th April 2018 — Adrian Cochrane
date: 2018-04-13 21:56:55 1200
categories: dev
---

This took me longer then I expected, but I finally managed to release an update that allows you to customize the topsites visible on [the new tab page](odysseus:home). It took so long because I needed to expose more capabilities to Odysseus's internal pages, but also because it's hard to see this working until I've pulled everything together. Saving your updates is entirely seperate from reading it back in, and both of those have their own "front-end"/UI and "back-end".

## Updating your database from internal pages
The first component that needed to be added was to allow forms on an internal (odysseus:*) webpage Odysseus's/your SQLite database. of links. Sure this could already be done using templating, but implying the SQL from the structure of a webform is more succinct and gives Odysseus the opportunity not to mess up the tab history with [non-idempotent](http://blog.teamtreehouse.com/the-definitive-guide-to-get-vs-post) requests. 

This is implemented by intercepting form submissions on the odysseus: URI scheme, though unfortunately the HTML forms targetting it need to be aware of certain restrictions on what input controls are handed to that trait via WebKit. Mostly though that just consists of writing `aria-hidden` rather than `type="hidden"`. From there it's a simple matter of constructing a simple [`INSERT OR REPLACE`](http://sqlite.org/lang_insert.html) SQL clause and submitting it to SQLite. On success it reloads the page rather than carrying through with the reload, and on error it renders an error page.

That error page is ofcourse implemented as a newly added template, which incorporates in the SQLite provided error message and the compiled SQL query with [syntax highlighting](https://highlightjs.org/).

## Querying SQLite from Prosody: Advanced
At first I thought I could write the query to fetch your top-visited pages in a single SQL query by joining multiple ones together via `UNION (ALL)`. But it turns out the syntax there doesn't [allow that](http://sqlite.org/lang_select.html#orderby). So rather than hacking around that syntax thereby making it read worse and obfuscating away optimization opportunities from SQLite, I instead went for extending the `{ % query % }` tag to be able to handle multiple queries.

Extending `{ % query % }` that way wasn't too hard, essentially involving little more than wrapping it in an extra loop. There was a catch however in that [Vala](https://wiki.gnome.org/Projects/Vala) doesn't trust itself to properly memory manage [SQLite objects](https://valadoc.org/sqlite3/Sqlite.Statement.html), so I had to implement my own [linked-list](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Linked%20Lists/linked%20lists.html) for it.

A couple of further features were added to work with those multi-statements, namely limits and exception queries. Limits are a number specified in the start `{ % query % }` tag that acts exactly the same way as SQL's `LIMIT`s, and involves little more than adding a loop counter (which has now replaced the empty flag for triggering the `{ % empty % } clause to render). And each inner loop runs over each `{ % except % }` SQL query to determine whether this row should be rendered (and counted) or not. 

## A nice drag & drop UI
Those utilities, and a database update, made it easy to define a topsites display where you can "pin" a link to the topsites, reorder the pinned links, and remove links from ever showing up there. But to make this UI shine, I used [progressive enhancement](http://alistapart.com/article/understandingprogressiveenhancement) and pulled in [HTML5Sortable](https://github.com/lukasoppermann/html5sortable). Then on drop I compute an appropriate ordering value for you and submit it to the database update trait.

This was the easy bit, as the core functionality was already there.
