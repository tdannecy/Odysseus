---
layout: page
title: 12th October 2017 — Odysseus Development Blog
posttitle: A Day's Work
header: 12th October 2017 — Adrian Cochrane
date: 2017-10-12 19:07:25 +1300
categories: dev
slug: 2017-10-12
---
It took me too long to get back to Odysseus development, but today I got a lot done on it. I've fixed some issues I've been having
with SQLite3, fixed some newcoming bugs, figured out where I currently stand in regards to EME, and made some fixes to my icon to
fit in even better with elementary's excellent ones.

# Where am I With EME?
I am happy to announce that Odysseus will not be complicit in placing executables on your computer that cannot undergo an
independant security review. And Odysseus will not use that software to restrict what you do with what downloads<sup title="Much of
what you'd probably want to do would, and should, be legal if not for unjust anticircumvention laws.">1</sup>.

To make sure of this I have added a simple anticonformance test to the [Prosody](https://alcinnz.github.io/Odysseus/architecture/2017/07/22/prosody.html)
testsuite. Since I always leave this internal page open on my computer it will tell me when the situation with EME changes. 

If you absolutely must have your NetFlix and Hollywood movies, may I recommend an [Apple TV](https://www.apple.com/tv/) or a "smart
TV"?

# New-Coming Bugs
Rebuilding Odysseus with the latest WebKit caused compilation to fail when
[WebKit.WebView.new_with_related_view](https://valadoc.org/webkit2gtk-4.0/WebKit.WebView.new_with_related_view.html) is used. Also
the latest Vala caused a crash whenever a "/" is typed into the addressbar. 

Thankfully it was trivial to switch to alternate APIs in order to sidestep these critical bugs. And GDB quickly told me what caused
the "/" issue. 

# Database Issues
I solved two majour issues caused by SQLite today. The first was a problem with SQLite not deleting windows when it was
determined they shouldn't be restored. This was solved by marking each window on-close with a "delete_group", where only windows
in the highest delete_group will be restored. These delete groups are incremented when the user browses, which is generally a good
indicator they haven't hit "Close All" in the application menu. 

The second issue was other applications could no longer open links with Odysseus. This turned out to be caused by the database
setup, which was done first-thing, not being able to get a database lock. Hence the fix was simply to move the initialization code.

# Icon Fixes
[Last time I talked about the icon](https://alcinnz.github.io/Odysseus/branding/2017/07/25/app-icon.html), I said it at least had
the potential to fit in well with elementary's excellent icon theme. Today incorporated some dominant missing elements encouraged
by [elementary's iconography guidelines](https://elementary.io/docs/human-interface-guidelines#iconography).

Specifically this involved fixing the [alignment](https://elementary.io/docs/human-interface-guidelines#composition), and adding
an [edge highlight](https://elementary.io/docs/human-interface-guidelines#shadows). The latter was a bit tricky as SVG, and in
turn InkScape, doesn't support the inner stroke primitive from which these highlights are defined. 

# Movie Recommendations
As for now, I think I'll move on to making a nice page of DRM-free movie recommendations to help replace NetFlix. Along this line
I've already curated a list of links to suggest you visit when first opening Odysseus, but that list is too long to
serve it's purpose of [getting you started](https://elementary.io/docs/human-interface-guidelines#first-launch-experience) using
Odysseus. Instead what I currently have will just overwhelm you.

So instead of recommending all those pages, I'll instead create well-presented collections of similar links and recommend those
from the initial homepage. A movies collection is certainly the most entertaining to create for
me<sup title="As for I'm sure many of you.">2</sup>. It's also I think the most valuable as I'm sure everyone can agree the ideal
solution to the injustice of DRM is for a Hollywood boycott to happen. It won't as those who watch Netflix, region-locked DVDs,
etc are indifferent to the DRM battle rather than supporters of DRM. 
