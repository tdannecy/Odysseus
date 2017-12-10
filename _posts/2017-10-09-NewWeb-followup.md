---
layout: post
title: "Followup: Hypothetical Web Redesign — Odysseus Development Blog"
posttitle: "Followup: Hypothetical Web Redesign"
header: 9th October 2017 — Adrian Cochrane
date: 2017-10-09 17:10:51 +1300
categories: misc
slug: NewWeb-followup
---

**NOTE** This is the final pure geeky entertainment post in this series about an alternative Web. The next post should be back to documenting Odysseus development. If you haven't already, I recommend you read [the first post in this series](https://alcinnz.github.io/Odysseus/misc/2017/09/26/web-redesign.html) first. 

To finish off my hypothetical concept of a Web redesigned from scratch, I thought I'd cover same aspects of the design I find fascinating, how I might redesign The Internet to underly this Web, and how I might govern this Web.

## What Nicities Naturally falls out of this Redesign
I addressed several underlying strengths of The Web in my first post and attempted to improve upon them. However aspects of those solutions also happens to ease common practices and weaknesses on our current Web. In part this includes:

<dl>
  <dt>Transpilers</dt>
  <dd>nBNF is specifically designed for parsing/lexing, the templating language is well suited to code generation, and the functional nature of that templating language is very well suited to optimizing programming languages. Together they'd probably serve as an ideal platform for developing new (potentially domain-specific) programming languages, by pure happenstance. Combine that with the content negotiation scheme and the way to use a transpiled language would be exactly the same as a native language.</dd>
  <dd>I don't know how I feel about this. But it would allow for new versions of the builtin languages to be released without breaking old versions, as long as those languages are identified by versioned URIs.</dd>

  <dt>Schema Negotiation</dt>
  <dd>One problem facing people who want to share data on The Web, not just documents, is that they can content-negotiate file formats like XML vs JSON vs RDF by MIMEtype but they don't have a way to content negotiate the schema used within those filetypes. Essentially this is the same problem that load to the downfall of SOAP.</dd>
  <dd>While the meaning of what a "schema" is would have to be defined by the filetype, since I've said filetype identifiers are dereferencable URLs to aid conversion, schemas are naturally supported via URL parameters.</dd>

  <dt>Pollyfills</dt>
  <dd>As mentioned in the first post, several aspects of this NewWeb can be self-hosted in other components of the language suite. This includes most builtin functions to any language, HTML/XML, and CSS. And I've already noted here that newer syntax can also be automatically pollyfilled (given a little care).</dd>
  <dd>What this means for web developers is that if the standard preludes to a webpage are given HTXP URLs (where browsers possibly override several builtins for efficiency, correctness, and platform integration), those features will autoupgrade so web developers will be able to use them without pollyfilling. Heck with HTXP it's even possible to use the correct implementation for when a webpage was published, though that could lead to mess.</dd>

  <dt>Linked Data</dt>
  <dd>Linked Data is a range of file formats which addresses several challenges for collaboratively sharing data. However to make it work significant tooling is required to work with it, and it's never gotten the uptake it needs to really shine. But on NewWeb it could possibly face faster adoption as it wouldn't require any special tooling.</dd>
  <dd><p>All NewWeb browsers can be taught the concepts of Linked Data exactly as it's defined today, without any special implementation needed or even desired from them:</p>
    <ol>
      <li>Conversions between different RDF formats can be trivially defined so all NewWeb browsers would apply them, simply because format conversion is exactly what NewWeb is designed to do.</li>
      <li><p>SPARQL Protocol And RDF Query Language can be implemented using a set of 3 conversions:</p>
        <ul>
          <li>An RDF to index conversion. For optimal performance on large datasets the publisher should run this.</li>
          <li>A parser for SPARQL with a template to lower syntactic sugar.</li>
          <li>A converter from a SPARQL index to Tab Seperated Values which takes a SPARQL query as a parameter. This is where all the more serious programmer would be done.</li>
        </ul>
      </li>
      <li>OWL inference can be incorporated into SPARQL by rewriting queries based on it's inference rules.</li>
      <li>Once you've got SPARQL SpIN/RIF (SPARQL Inference Notation/Rule Interchange Format) is not far away, depending on which implementation you use for inference.</li>
      <li>With HTXP cryptography and the published rules, the unifying logic, proof, and trust layers would be absolutely trivial.</li>
    </ol>
  </dd>

  <dt>Crowdsourced Translations</dt>
  <dd>Some tooling would be required to get this to work, but a template could trivially be developed which substitutes in reader contributed translations, and that template could trivially solicit user contributed translations.</dd>
  <dd>Machine translation is a bit more challenging.</dd>
  
  <dt>Free Software</dt>
  <dd>The network security model aligns well to the Free Software ideology: to make a great experience which doesn't always ask for a user account, you must determine what is the user's computation and what is the community's. Beyond that all the code powering a website would be available in human readable form via "view source". Obfuscation would be less harmful as the languages are designed to make their dominant operations, their I/O, extremely clear independant of formatting.</dd>
  <dd>That said Python-style indented blocks could discourage making controller code difficult to read.</dd>
  <dd>Then with the WYSIWYG described below even non-developers can understand and fork pages, making NewWeb a fully freesoftware system.</dd>
  
  <dt>Flattr Integration Point</dt>
  <dd>While a Flattr-like system would be seperate from NewWeb, just due to currency negotiation it would be granted a fascinating integration point into any NewWeb browser.</dd>
  <dd>It could register itself as a (fake) currency, and decorate another (real) currency. From there it's code could entirely offline split the monthly payment between specified artists. I like this arrangement as now all artists are saying is "please donate money to me", while consumers are given the choice of saying "I want to split a monthly between these artists." No longer are artists accepting Flattr, or any currency, just because they think it'll gain traction amongst consumers, the decisions are more decoupled.</dd>
  
  <dt>Gravatar</dt>
  <dd>Simply define a standard subpath for avatars to be located at.</dd>
  
  <dt>Wayback</dt>
  <dd>I've explicitly built it's features into NewWeb, but given the page history is made up of header links it's trivial to self-host a page-history viewer. At most this would require the development of a charting library kind-of like D3.</dd>
  <dd>Should librarians want to ensure the longevity of pages, they can run a separate operation where they have a computer trading for new HTXP blocks and instead of throwing old data out these computers would be backed with ever increasing storage space.</dd>
  
  <dt>WYSIWYG</dt>
  <dd>Naturally a languages AST could be parsed with nBNF, rendered with a templating, editted via a controller, and published via a form. Together this makes an excellent platform for developing WYSIWYGs, and the domain-specific nature of these same languages would make it relatively easy to design a WYSIWYG for them.</dd>
  <dd>This would ensure that technical knowledge is not required to participate in making cool webpages.</dd>
  
  <dt>Collaboration</dt>
  <dd>NewWeb could trivially be extended with a URL scheme which browsers could use to let users collaboratively interact with any webpage. The network protocol behind this would send operational transforms to all accepted collaborators. Those collaborators would in turn apply those operational transforms in whatever order they received them in before partially rerendering the page. The pass-by-value nature of the controller would aid the design of these operational transforms.</dd>
  <dd>Combine this with the WYSIWYG and we essentially have Google Docs, which otherwise wouldn't be able to make it past the security model.</dd>
  
  <dt>Distributed Version Control</dt>
  <dd>Distributed Version Control and the HTXP header links have the same structure: a DAG. Add format conversion and the current state of the repostory, and a UI upon it, could be rendered. URL parameters would allow modes to provide multiple perspectives on the repository + it's history. Add publishing forms and the repository could be updated.</dd>
  <dd>Then add configuration to the version control format and optional inverse links to published content, and we can have issue tracking + pull requests.</dd>
  <dd>The parsing and templating capability would be very capable of syntax highlighting for a nicer UI, especially when they're used to add a domain-specific syntax upon themselves for this very purpose. Also the natural NewWeb browser optimization of lazy functional programming would implement the performance characteristics for us.</dd>
  
  <dt>Infinite Scrolling</dt>
  <dd>Comes naturally to all pages when browsers implement "lazy functional programming" optimizations for the templating. They'd just stop rendering the template as it flows offscreen.</dd>
  
  <dt>Crawlers</dt>
  <dd>Just see what comes up on a computer in it's HTXP trading.</dd>
  
  <dt>Blogging</dt>
  <dd>Jekyll blogging is supported pretty much out of the box. Jekyll is the technology behind this site. </dd>
</dl>

Ofcourse it's also fascinating that it doesn't cost anything to run a wiki, forum, or most websites. 

## Ideal Underlying Internet
If the Internet needed to be rebuilt along with the Web, what Internet would best underly NewWeb.

It's main requirement is for there to be a protocol for syncing senstive files like the private key for a user account, as any other user experience around the cryptographic online accounts would be terrible. This in turn requires multicasting to all other hosts under a domain (henceforth "nick"), and unicast to specific hosts to request changed files. Ideally this file syncing protocol and the multicasting protocol would allow for relays to buffer messages and changed files until a nick comes back online without knowing what content is being shared, just to take reliability concerns out of peer-to-peer systems. 

The multicasting protocol would relay messages along minimum spanning tree and find the appropriate minimum spanning tree to join via DHT routing. Each link in the MST would send back an ack for partial reliability. Additionally for submitting forms to a nick, I'd use this same infrastructure to create a weighted random reliable and encrypted any-cast. This scheme is quite similar to Tox, and has the nice sideeffect of being an excellent platform for implementing one-on-one communication protocols (e.g. video calls, SMS, eMail) and the "continuity" user experience Apple's chasing. Allow multicast groups to be combined in a DAG and we can extend the one-on-one communication protocols to groups. 

Beneath this we need unicast routing. While IP could be used here, I'd probably opt for mesh routing. This would involve having each host track routes to their physically (by hops) and logically (by XOR distance) closest neighbours, and use it to route each other's messages. If they don't have a route to a destination, the host would wrap the packet up in a new one and send it on to the logically closest host it knows of. 

However to make that mesh routing efficient we need a large number of physically close neighbours. To address that I'd add a path-based routing protocol, implemented efficiently using the rotated bitshift operation. And beneath that I'd have a range of physical connection protocols like Ethernet, WiFi, and satellite. This resembles Hyperborea quite closely and has the nice benefits that it significantly reduces the need for ISPs and wifi hotspots, as well as the fact it's DHT routing could be encrypted to natively support Tor-like privacy. 

## Governance
Any Internet and Web would require a standards organization to maintain it's interoperability. Ours is no different. 

My main concerns for this hypothetical standards organization is for 1) the task of developing a web browser engine to always be tractable (it isn't for today's web) and 2) for it to have low-cost of entry (I view that as a fundamental drawback to the design of the W3C, as it skews who gets to have a say). Thankfully this NewWeb has characteristics to help address these shortcomings. 

While I have no idea of what the process would be for developing a web standard, I would have much the work done over a wiki potentially with occasional in-person meetings much like the IETF and W3C's moving to. And like the W3C there'd be a director responsible for signing off on standards before they're considered "recommendations". 

However unlike the W3C it'd also be the directors job to lead the development of a self-hosted web browser (which on it's own isn't fully functional) that'll automatically polyfill existing browsers and otherwise ensure the task of implementing a browser engine remains tractible. These development tasks would likely incorporate the maintainance of developer tools, and unit-tests for the standards. 

Also there'd be no server costs for running the wiki, discussion boards, publishing the standards, and any code hosting. This means that the cost to participation can be extremely low if not non-existant. 

### How I'd Handle EME
I've made it clear that I dislike the W3C's action of endorsing the EME standard<sup title="I'm actually still sour from this as not only has a dominant figure declined to help give our movement more sway, but his argument puts me against everyone watching NetFlix. That's a difficult battle to win, as in all actuality the NetFlix audience have no stake in it.">1</sup>. However given the setup I've described I don't know if I'd do much different as a director of this hypothetical organization.

Not because DRM might be bit less opprossive if we have browsers fighting it's worst aspects via yet more wasted computation (Tim BL's argument), that's not enough to justify the injustice. I'd do it because in my setup it'd give me a platform to grow the opposition. Once I let the standard through, it'd be my responsibility to create a message saying the feature isn't supported. Normally I'd have to provide a fallback implementation, but because the free-software constraints on that work it wouldn't allow me to actually implement it.

And if I'm writing a message or even a video to say EME isn't supported, I might as well explain why this is a *good thing* and tell viewers to complain to the site they're seeing this message on. 
