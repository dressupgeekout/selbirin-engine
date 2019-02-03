# Architecture

Selbirin Engine is written entirely in Ruby. Interprocess communication is
handled with the help of Rinda, which is an implementation of the [Linda
coordination model](linda) which comes with Ruby's standard library.

The server is little more than a wrapper around the Rinda [tuple
space](tuple space).

Conceptually, a Selbirin world is a Rinda tuple space of `Selbirin::Thing`
objects. A Thing can contain any key-value pairs of data it wants, but there
MUST be at a minimum (1) a "name", and (2) a "description".

In practice, there are 3 kinds of Thing which are used on a regular basis:
Characters, Artifacts, and Locations.

The primary differences between a `Selbirin::Character` and a
`Selbirin::Artifact` are that Characters can talk and Characters can
interact with Artifacts and other Characters. Artifacts, on the other hand,
are intended to represent physical implements that Characters may "use."

Every thing must exist in an established `Selbirin::Location`. It is
impossible for a Thing to be not located in a Location. However, there
exists a special Location called `:__NOWHERE__`, which aids in such tasks as
temporarily removing a Thing from the World. Most notably, players who log
out of the World server are not deleted from the world, but rather are
moved to `:__NOWHERE__` until they log back in again.

[linda]: https://en.wikipedia.org/wiki/Linda_(coordination_language)
[tuple space]: https://en.wikipedia.org/wiki/Tuple_space
