# TODO


**database writing ratelimiting.** it's too easy to spam the database like
this:

    loop { Artifact.new.sync! }

**proper authentication.**


**graphical interface.** apparently it's tricky to combine Ruby, GTK and
several threads?? >:|


**metrics.** need to find out _limits_ and things like that. At times it is
very difficult to intuit how much Distributed Ruby can handle. In particular, I
want to figure out just how expensive `Rinda::TupleSpace#read_all` is.


**somehow come up with the list of actions for any object** -- a character is
supposed to be able to inspect any object in the vicinity and get a list of
things to do with it. i guess if there's only one thing to do, then default to it?


**colors in curses!!** because _come on_

**require names and descrs, always.** it's too easy to get away with name
and/or descr being nil. it should be 100% required.
