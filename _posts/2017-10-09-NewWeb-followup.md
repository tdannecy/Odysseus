---
layout: post
title: "Followup: Hypothetical Web Redesign — Odysseus Development Blog"
posttitle: "Followup: Hypothetical Web Redesign"
header: 9th October 2017 — Adrian Cochrane
date:
categories: misc
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
  <dd>Comes naturally to all pages when browsers implement "lazy functional programming" optimizations.</dd>
</dd>
