---
layout: post
title: 4th December 2017 — Odysseus Development Blog
posttitle: New Recommendations Site
header: 4th December 2017 — Adrian Cochrane
date: 2017-12-04 16:24:43 1300
categories: webdev
---

I've just put some time consuming effort into the first-launch experience of Odysseus, and unlike most other browsers it's not a tour of Odysseus's features. Instead [inline with the HIG](https://elementary.io/docs/human-interface-guidelines#first-launch-experience) it's a [well-presented bunch of links](https://alcinnz.github.io/Odysseus-recommendations/)<sup title="While that's not exactly the wording of the guideline, it is how it applies to Odysseus">1</sup>. 

The work was timeconsuming as to achieve it I had to explore lots of links, categorize them, and make sure they all had icons. Once I did that, it was a relatively simple task to restructure the webpage to be less overwhelming. 

My work is specifically targetted to the English-speaker local, so if any of you are multilingual web developers who love to collect links please try your hand at making a similar site and [tell me about it](https://github.com/alcinnz/Odysseus-recommendations/issues). 

### The Ultimate Vision
While this recommendations page is pretty nice, I ultimately want to have Odysseus show newcomers a random sampling of links identified by screenshot rather than favicon. Then as time goes on that page will automatically become more personalized. Maybe I'll even suggest pages the surfer hasn't visited, though I'd insist on not using a central server to do so<sup title="Minhash combined with an anonymising pub-sub network looks interesting to try out for this purpose.">2</sup>.

Then when I went to collect links it quickly became apparent that if I implemented that naively then some category of link may oversaturate other categories the newcomer may be more interested in. Careful organizational thought needs to be put into the link collection in order to avoid that problem, and maybe some visual design work<sup title="Work designing pages to hold categories of links">3</sup> depending on how I want to deal with this. 

So I'm presenting my collection as categorized favicons in order to get the crowdsourcing started. 

#### Help Wanted

In order to achieve that vision, I need help from a casual or professional Librarian and a Visual Designer<sup title="I'm good at interactive design, but I'm slow at visual design.">4</sup>. So if you want to fill either or both of these roles, please eMail [me](mailto:alcinnz@lavabit.com). Thanks. 

### Glossary
For my own sake of mind, I've been differentiating between the terms recommendation and suggestion. 

I use *recommendations* to refer to "recommendations from the Odysseus developers", where the links curated but suggested to a large group. Meanwhile I use *suggestions* to refer to "personalized suggestions", where the links are suggested to you personally by an algorithm. 

It just helps if I can keep these concepts seperate. 

---

1. While that's not exactly the wording of the guideline, it is how it applies to Odysseus. 
2. [Minhash](https://robertheaton.com/2014/05/02/jaccard-similarity-and-minhash-for-winners/) combined with an [anonymising pub-sub network](https://ipfs.io/blog/25-pubsub/) looks interesting to try out for this purpose.
3. Work designing pages to hold categories of links. 
4. I'm good at interactive design, but I'm slow at visual design.
