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


## Character->Artifact Interaction Protocol

An Artifact must respond to the method `#actions` which returns an array of
ActionSpecs. An ActionSpec consists of a human-readable name and a
machine-readable identifier for the method which implements this action.

For example, the following implements a Potion which can be drunk or broken.

```ruby
class Potion < Selbirin::Artifact
  def actions
    return [
      ActionSpec.new(:drink, "Drink it."),
      ActionSpec.new(:break, "Break the bottle."),
    ]
  end

  def drink
    # ...
  end

  def break
    # ...
  end
end
```

The first argument of `ActionSpec.new` must be a symbol; it represents the
method which will be called when a Character performs the specified action.
It is an error to provide the user an ActionSpec which represents a method
that cannot be invoked.

Note that `#actions` is not an array, but rather a method which must return
an array. This means that the set of actions available to an Artifact can
change based on other factors. For example, "open the lock" might be
available only while the Character is in possession of the appropriate key.
Or maybe only certain kinds of Characters can interact with the Artifact in
certain ways. It's all up to you!

[linda]: https://en.wikipedia.org/wiki/Linda_(coordination_language)
[tuple space]: https://en.wikipedia.org/wiki/Tuple_space
