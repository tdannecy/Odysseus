---
layout: post
title: 11th December 2017 — Odysseus Development Blog
posttitle: "Release Cleanup: Day 5"
header: 11th December 2017 — Adrian Cochrane
date: 2017-12-11 14:11:05 1300
categories: cleanup1.0
---

Today I focused on the `Widgets/header` package, but as that's mostly code sourced from [other](https://github.com/elementary/files/blob/master/libwidgets/Chrome/ButtonWithMenu.vala) elementary [projects](https://github.com/elementary/wingpanel/blob/master/lib/Widgets/AutomaticScrollBox.vala) there wasn't much to clean up leaving me to focus on the `AddressBar`. `AddressBar` was already very nicely written, in part because of how simple it is, but I did manage to find some things to correct. 

At the lowest end there was a tiny bit of defunct code and expressions which could be written more concisely. At the other end it didn't quite take up all available space at certain window sizes and clicking an autocompletion didn't navigate to that link. 

The thing with sizing the addressbar is that left to it's own devices a text entry allocates itself a "natural size" that's much smaller than what I need. At the same time the headerbar doesn't know to expand it's title widgets to fit all available space, so those are left at their "natural size"<sup title="Or at least that's the behaviour I found while implementing the addressbar. Things might have changed now.">1</sup>. To fix this the natural size has to be much bigger so the headerbar knows to fill all available space with it. 

As for the fact you couldn't click an autocompletion to navigate to it's page, that was a surprisingly quick fix. I previously called two methods in the wrong order, causing an event handler to be added to the completions list before it existed. That's no longer an issue.

---

After that I attempted to upgrade the ButtonWithMenu code I'm using to be inline with [Pantheon Files](https://github.com/elementary/files)<sup title="Turns out there weren't any changes to this file to be commited.">2</sup> and tidied up the widgets which overlay ontop of webpages. While there were one or two codestyle issues to fix, most the problems were bigger than that but yet had trivial solutions. 

The `FindToolbar` had two issues: a bit of menu positioning logic was extra clutter and it was using deprecated APIs to turn the text red when some text can't be found on the page. The former was fixed by utilizing the `ButtonWithMenu` class I was using elsewhere. And the latter was fixed by switching to a newer API which is more concise and semantic, basically it involves applying a `.error` class to the entry just as one would on the Web. 

The other issue with that code was that it had a previous attempt at making JavaScript popups more modal, one which didn't work and wasn't hooked up to anything. That attempt involved overlaying a widget to block all interactions with the webpage while it was open. Turns out that wasn't necessary as I can instead have the relevant trait configure the webview not to respond to any events (to be `insensitive`) while it's `InfoBar` is open. On it's own that doesn't communicate that the page is inactive, but that can be solved simply by utilizing the statusbar text. 

---

1. Or at least that's the behaviour I found while implementing the addressbar. Things might have changed now.
2. Turns out there weren't any changes to this file to be commited.
