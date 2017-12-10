---
layout: post
title: "Re: What Should Follow the Web — Odysseus Development Blog"
posttitle: "Re: What Should Follow the Web"
header: 26th September 2017 — Adrian Cochrane
date: 2017-09-26 10:56:16 +1300
categories: misc
---

**NOTE** This is a continuation of the [previous pure geeky entertainment post](https://alcinnz.github.io/Odysseus/misc/2017/09/26/web-redesign.html), and a reply to the continuation of the post which inspired that.

As it turns out me and [Mike Hearn](https://blog.plan99.net/what-should-follow-the-web-8dcbbeaccd93) were coming from very different places, and as such our solutions turned out to be very different.

His solution comes focuses on aiding the development of cross-platform apps built on central ([Permazen](https://github.com/permazen/permazen)) databases and a choice of languages (possibly via the [JVM](https://en.wikipedia.org/wiki/Java_virtual_machine)), and linking between those apps. Also he complains about addressbars in browsers as being a usability issue<sup title="I wouldn't have included it in Odysseus if I thought it was unusable">1</sup>, despite the fact any issues there are really caused by uncaring websites and the fact that [Safari shows it can be solved](http://www.technoven.com/wp-content/uploads/2015/05/Safari-Browser.png) if it is indeed an issue. Heck editing this post on GitHub and in Odysseus I see "https://github.com/alcinnz/Odysseus/new/gh-pages/_posts" there, it's very readable. 

My [hypothetical solution](https://alcinnz.github.io/Odysseus/misc/2017/09/26/web-redesign.html)<sup title="I've actually been sitting on this for a while, because I'm wierd">2</sup> was all about improving the Web's strengths at sharing information. This involved largely replacing HTTP and substituting the general purpose language JavaScript with a few more domain-specific languages (a few of which I made sure were still turing complete so as not to be limiting), because we have [much better solutions](https://ipfs.io/) to distributing information now than HTTP<sup title="Solutions with better performance, reliability, privacy, and no 404 errors.">3</sup> and I *love* the Web's domain specific languages. 

In short his IDE would make his Web approachable to new-coming developers, whereas my IDE would make it approachable to non-developers. 

---

But really my objection to his solution is that I think his NewWeb is unnecessary.

Outside of [Google's offerings](https://www.google.co.nz/intl/en/about/products/) The Web leans heavily towards the documents end of the [documents-applications spectrum](https://ar.al/notes/the-documents-to-applications-continuum/). This is not to say most websites don't have app-like features, but those features are relatively minor and are not the attraction to the site. Successful apps on the otherhand attract people with their features rather than their content<sup title="If they have any 'content', it'd generally come from the Web anyways">4</sup>. This is just what the user experiences of The Web and native platforms lend themselves to. 

As such it's appropriate for The Web to focus on how better to aid the distribution of information while pushing app development to the excellent platforms and stores offered by [elementary OS](https://developer.elementary.io/), [Mac OS X](https://developer.apple.com/macos/), [iOS](https://developer.apple.com/ios/), [Windows](https://developer.microsoft.com/en-us/), etc. If you're complaining these platforms are not "[open](https://opensource.org/)", by all means please promote [elementary](https://elementary.io/). It's [far more open](https://elementary.io/open-source/) than the thousand-and-one "Recommendations" from the [W3C](https://w3.org/) which no new upstart browser can hope to reimplement<sup title="To work around this I'm piggybacking on Apple's efforts">5</sup>.

If you instead want to develop another cross-platform application framework, apparantly you haven't learnt the lessons of history. An app designed for a specific operating will always outcompete you on that platform, and your cross-platform app will [die from a thousand cuts](https://www.smashingmagazine.com/2012/06/mobile-considerations-in-user-experience-design-web-or-native/#death-by-a-thousand-cuts). I'm afraid Hearn's solution will die from the same problem. 

Or maybe his solution would succeed amongst the developers who's emotional buttons were pressed enough to think The Web succeeded over native. 

---

1. I wouldn't have included it in Odysseus if I thought it was unusable
2. I've actually been sitting on this for a while, because I'm wierd
3. Solutions with better performance, reliability, privacy, and no 404 errors.
4. If they have any "content", it'd generally come from the Web anyways
5. To work around this I'm piggybacking on Apple's efforts
