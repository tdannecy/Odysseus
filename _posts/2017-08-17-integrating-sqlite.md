---
layout: post
title: Integrating SQLite — Odysseus Development Blog
posttitle: Integrating SQLite
header: 17th June 2017 — Adrian Cochrane
date: 2017-08-17 08:52 +1200
category: development
slug: integrating-SQLite
---

I like [HTML](https://www.w3.org/html/) and [CSS](https://www.w3.org/Style/CSS/).
HTML's syntax is specifically designed to make it easy to specify the typographic
meaning of text to be communicated to users, and incorporating other resources into
it. CSS meanwhile is specifically designed to specify how to communicate that
typographic meaning. Compared to this
[JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript) is a bit of
a cope-out with it's [turing complete](http://wiki.c2.com/?TuringComplete) control
flow taken straight from [C](http://www.cprogramming.com/). However
[SQL](https://sqlite.org/lang.html) is not, and that's why I have recently integrated
it into Odysseus (for it's own use) via SQLite. 

SQL, like HTML and CSS, is a domain specific language. Specifically one for
summarizing data saved to disk. For this purpose it's a very elegant language —
you specify the conditions to be satisfied by all returned data, and it
[figures out](https://sqlite.org/queryplanner-ng.html) an efficient algorithm to
answer that query. In SQLite these algorithms almost exclusively use
[BTrees](https://xlinux.nist.gov/dads/HTML/btree.html), a very versatile
datastructure which can function as a [map](https://xlinux.nist.gov/dads/HTML/dictionary.html),
[set](https://xlinux.nist.gov/dads/HTML/set.html), and/or
ordered-[list](https://xlinux.nist.gov/dads/HTML/list.html). Furthermore SQL databases
abstract away [procedures](https://sqlite.org/atomiccommit.html) they use to ensure
updatesare fully applied or not at all. All these features make it easy to summarise
data using SQL without worrying about the step-by-step procedures involved, just as
CSS makes it easy to express how to present a page without worrying about computing
[the exact position of everything. 

As a strong "[domain-specific language](http://beautifulracket.com/introduction.html)"<sup title="Even if most people use it as dumb storage when it's actually smart.">1</sup> SQL complements HTML and CSS very nicely, which
could explain why it underlies almost every non-trivial website you care to mention. If
anything SQL, HTML, and CSS makes it too easy to build websites because many developers
seem to feel a need to overcomplicate things<sup title="This often leads to a subversion
of user expectations, and I've met some of these users.">2</sup>. The only catch with
using SQL this way is that there needs to be
[a way](https://alcinnz.github.io/Odysseus/architecture/2017/07/22/prosody.html) to incorporate
SQL output into your HTML source code. 

## What brings this on?

I've recently finished integrating SQLite into Odysseus, and using that integration to
better persist Odysseus's state. Using SQLite for this purpose allows me to specify
what data I want to persist without specifying the syntax that should be used to save it
to disk, and with little effort to upgrade the structure of the saved data to allow for
future features. 

Furthermore SQLite [aims](https://sqlite.org/aff_short.html) for it's database files to
outlive the applications which writes it. For Odysseus this will mean that when I save
bookmarks to SQLite, you'll always be able to read it somehow. 

So far I have been using SQLite as dumb storage, but I'm sure that won't last. The main
challenge in doing this has been to differentiate closing the application from closing
tabs and windows. 

## Technical Details

The [raw SQLite library](https://valadoc.org/sqlite3/Sqlite.html) is used over
[GDA](https://valadoc.org/libgda-5.0/Gda.html), with a few simple utility functions. This
ensures I can access the raw SQL syntax from both Vala and eventually Prosody.

To initialize the database a sequence of SQL statements need to be executed against the
database as the application starts, but none of those statements should be rerun across
different application runs. To prevent these statements from being rerun, it's useful to
store a schema version and check it before potentially rerunning a statement. 

This was implemented in Odysseus by storing the schema version near the start of the file
using [`PRAGMA user_version;`](https://sqlite.org/pragma.html#pragma_user_version). Then
that's fed as input into a Prosody template, who's output is streamed into SQLite. This all
happens first thing as Odysseus starts. 
