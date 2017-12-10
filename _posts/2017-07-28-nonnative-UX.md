---
layout: post
title: Non-native UX — Development Blog
posttitle: On Non-native UX
header: 28th July 2017 — Adrian Cochrane
date: 2017-07-28 16:50:54 +12:00
category: UX
slug: nonnative-UX
---

As you may well know, Odysseus aims to feel native to [elementary OS](https://elementary.io/). However sticking too rigidly to the familiar and native controls may actually hurt the user experience. This might be when the Web UX Odysseus exposes handles page navigation better then those native controls, or it might be when a native control seems to be designed for the purpose you have but really handles a different one. The latter can be especially tricky when that native control has some atypical behaviour that's tricky to reimplement.

This was exactly the situation I was facing for several weeks with the [Gtk.EntryCompletion](https://valadoc.org/gtk+-3.0/Gtk.EntryCompletion.html). Previously completions (including the implied "http://" on web addresses) had to be manually selected and then submitted, because that's how `EntryCompletion`s work<sup title="It was designed for, say, autocompleting musicians from those the user previously entered.">1</sup>. But after several attempts this issue is now solved! That's not to say however the addressbar's behaviour is perfect yet, or that the code doesn't need some cleaning up.

The solution I came to was to place a [Gtk.ListBox](https://valadoc.org/gtk+-3.0/Gtk.ListBox.html) inside a variation of [Gtk.ScrolledWindow](https://valadoc.org/gtk+-3.0/Gtk.ScrolledWindow.html) and in turn a nonmodal [Gtk.Popover](https://valadoc.org/gtk+-3.0/Gtk.Popover.html). The keyboard focus is left on the addressbar (rather than the completions) and some simple event handlers integrates the completions nicely into the [Gtk.Entry](https://valadoc.org/gtk+-3.0/Gtk.Entry.html) addressbar. To allow the selection of different autocompletions I unfortunately had to reimplement the population of the listbox as well as management over which completion is selected<sup title="Thankfully in Odysseus's case this was quite simple.">2</sup>.

Behind this I have a number of "completers" and an object to multiplex their results into a single stream for the UI to handle. 

## User Experience

Designwise it is a tricky balance when you have to replace a native control as you neither want it to look too familiar or too different. If it's too familiar it fails to communicate that the keyboard interaction is (for good reason) quite different. If it's too different the user won't be able to transfer any knowledge. 

Here we handled it by creating a layout for the completions impossible to achieve with the native control, and the popover arrow certainly helps some too. Other than that the basic behaviour is largely the same as a the normal completions on a textbox, with the notable exception that it's not possible to not have a completion selected. 

While I haven't tested it, this should work reasonably well with screenreaders like Orca. 

## Moving on From Here.

My focus now would be on tidying up a few more non-desirable behaviours (e.g. when you focus the addressbar you probably want to copy the web address or type in a new one, hence Odysseus should select it all for you) with measures which should be much simpler. Furthermore I may do some minor refactoring and code cleanups around this feature. 

---

1. It was designed for, say, autocompleting musicians from those the user previously entered.
2. Thankfully in Odysseus's case this was quite simple.
