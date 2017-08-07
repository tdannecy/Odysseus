Odysseus is now much better at saving it's state so that when you open it it will restart from where left off browsing. This important feature, common both to elementary apps and web browsers, was implemented (again) by integrating SQLite. 

SQLite is a high quality relational database designed (written in C) to be embedded in application software rather than to be ran on a central server. It will also be a vital component for several future internal pages like history and bookmarks. 

## How is SQLite used?

SQLite (unlike other relational databases) stores all it's data in a single file, which Odysseus places alongside a bunch of WebKit specific state in it's local configuration directory. Upon opening this database Odysseus will check it's version<sup title="Using `PRAGMA user_version`">1</sup> (which SQLite stores near the start of the file), and apply the SQL from a template file to apply any database manipulations necessary to bring the database structure up to date with what Odysseus expects. 

The raw SQLite library is used to manipulate this database rather than libGDA, with a few simple utilities to make the APIs nicer to use in Vala. 

## How is SQLite a benefit?

Like most databases SQLite makes it easy to:

* Define and alter the structure of data that is to be saved to the disk.
* Not worry about how the data's encoded.
* Alter specific segments of the saved state. 
* Compute various summaries of the data.

The first benefit makes it easy for me to upgrade the database (as described above) to add more data in the future.

The second benefit prevents me from having to worry about encoding, unlike earlier versions where I stored data in a TSV file.

The third benefit allows Odysseus to keep data up-to-date in case of a crash.

And the final benefit will translate directly into stronger UIs for e.g. viewing browser history.

Furthermore because SQLite runs in-process and writes to a single file (or rather two), it is better suited for app development.
