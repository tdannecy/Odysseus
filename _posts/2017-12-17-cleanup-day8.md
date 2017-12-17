---
layout: post
title: 17th December 2017 — Odysseus Development Blog
posttitle: "Release Cleanup: Day 8"
header: 17th December 2017 — Adrian Cochrane, Bsc
date: 2017-12-17 19:24:47 1300
categories: cleanup1.0
---

Today I reimplemented the internationalization infrastructure for internal pages. This has long been a source of SEGFAULTS whether I used OS internationalization or my own code, so I rewrote that infrastructure yet again today. On a similar note I also setup a [Transifex](https://www.transifex.com/) account for [Odysseus](https://www.transifex.com/none-483/odysseus/dashboard/). Unfortunately the translatable text from the internal pages have not been loaded into Transifex due to it's custom code. Maybe if I can get a [WebLate](https://weblate.org/) instance (perhaps my own or [elementary's](https://l10n.elementary.io/)) I can hack it to understand my messages format. 

The translation infrastructure for the internal pages involves a new `{ % trans % }` tag which behaves much like `{ % with % }` (and may in most cases reuse the same code), but attempts to swap out the template segment between it and `{ % endtrans % }` with one from a catalogue file. This catalogue file is read in as a singleton and is read using the same parsing infrastructure used by the rest of Prosody. 

It's important that the catalogue file is read only once (upon first use) as that prevents the harddrive, which is relatively very slow, from being accessed multiple times per template. Performance wise it's also notable that for each message Odysseus scans all translated messages (which are now in memory) until it finds the relevant translation. In theory this provides good, but not great, performance in terms of the CPU<sup title="But then again, modern CPUs do get well-tuned for scanning operations.">1</sup> whilst being very though not perfectly efficient in terms of memory usage.

Finally for memory and CPU performance a cache is maintained to aid reusing translations which are already in memory anyways. This both reduces memory usage by reducing duplication and CPU performance by not spending time regenerating that template.

All these performance measures basically brings us back to the same performance characteristics I've explicitly given Prosody. It isn't microoptimized to perform well on the CPU, but it is well optimized not to use extraneous memory. 

---

Alongside this I had to rewrite the template messages extractor to use the new syntax. There I ended up removing the generation of contextual data and the logic for merging in the new messages, basically because I decided while these features are useful it's not what I want to spend my time implementing. They are not vital.

That and my Transifex work showed me that it'd be great for Odysseus to adopt Mason for a build system over CMake. I think I'll be able to understand it easier, and as both [Meson](http://mesonbuild.com/) and that message extractor are written in [Python](https://www.python.org/) it'd be easier to integrate them. But then I'd love extend Odysseus in some very elementary ways. 
