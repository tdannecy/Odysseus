---
layout: post
title: 7th December 2017 — Odysseus Development Blog
posttitle: Release Cleanup: Day 1
header: 7th December 2017 — Adrian Cochrane
date: 2017-12-07 19:19:54 1300
categories: cleanup1.0
---

Today I started to look at what partial refactorings I could finalize, what deprecated APIs I could move away from, and how I could otherwise clean up my code. I'm doing this file by file, and have just decided I wanted to blog about each set of files I do. As such this is the inaugural post on the summer cleaning progress.

Today I did the Odysseus.Application class, and after today the code is **much** tidier. Specifically I:

1. Removed the old flatfile persistance logic, new replaced by SQLite. 
2. Split up the overriden `command_line` into standard methods. 
3. Removed the metadata, as that has moved into a cuople of metadata files.
4. Simplified the commandline interface.

The latter is partially done as part of breaking up the command_line method as that was refusing to accept the old flags I included. Now I've removed the new-tab flag in favour of opening a specific API, and created a psuedo-URI for opening new windows so that the `open` method can receive (because nothing else was recieving the the old argument unless I broke the refactor by implementing the command_line method again). 
