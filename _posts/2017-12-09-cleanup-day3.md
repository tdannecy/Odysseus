---
layout: post
title: 9th December 2017 — Odysseus Development Blog
posttitle: "Release Cleanup: Day 3"
header: 9th December 2017 — Adrian Cochrane
date: 2017-12-09 18:17:08 1300
categories: cleanup1.0
---

I've still been on `BrowserWindow` refactoring today, working on some much more intense refactoring. Essentially the main thing I did was to extract out the common layout patterns into a `HeaderBar` subclass so I can write the `BrowserWindow` code a bit more declaratively. It's not as concise as the psuedocode I shared yesterday as it wasn't worth it (unlike [before](https://alcinnz.github.io/Odysseus/architecture/2017/07/22/prosody.html)) to implement that syntax; it creates more effort then it [saves](https://xkcd.com/1205/). 

The increased code clarity isn't the only thing that came out of this effort, it has also helped me to:

* Move away from deprecated APIs like `AppMenu`
* And expose more functionality (e.g. reload ignoring cache) and more keyboard shortcuts. 

The open and save actions further benefitted from abstracting the `FileChooserDialog` behind a new method, something akin to JavaScript's `alert`/`prompt`/`confirm` APIs. Once I combined that wrapper method with a `foreach` loop, I found I could make cancel handling implicit in the code while being fully functional. 

So while it took quite a bit of effort to perform this refactoring, it is well worth it both for developers and users of Odysseus. And certainly a lot nicer for me as a member of both groups. 
