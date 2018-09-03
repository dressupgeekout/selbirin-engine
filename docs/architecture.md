# Architecture

XXX is written entirely in Ruby. Interprocess communication is handled with
the help of Rinda, which is an implementation of the [Linda coordination
model](linda) which comes with Ruby's standard library.

The server is little more than a wrapper around the Rinda [tuple
space](tuple space).


linda: https://en.wikipedia.org/wiki/Linda_(coordination_language)
tuple space: https://en.wikipedia.org/wiki/Tuple_space
