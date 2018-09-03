# Internals

## In general

Each element of the world can be expressed as a big, nested dictionary. It
is trivial and straightforward to translate these dictionaries into a
compact JSON form. More importantly, one should be able to reconstitute the
entire state of the world by means of interpreting several JSON documents.

Every object has the following structure:

    {
      "id": STRING,
      "kind": STRING,
      "attrs": {
        "__class__": STRING
      }
    }

The top-level `id` and `kind` fields are not available for users to
manipulate. On the other hand, users _are_ encouraged to add as many custom
attributes in the `attrs` sub-object as they see fit.

XXXMYNAME reserves all attributes whose name begins with an underscore, such
as `"__name__"` or `"__location__"`.



## `Thing`

Attributes:

- `__descr__`: (String) A "one-line" description of this thing.
- `__name__`: (String) The name of this thing.


## `Character < Thing`

Attributes:

- `__location__`: (String) The ID of the Location.
- `__passphrase__`: (String) The SHA256 of the passphrase concatenated with
  the salt.
- `__salt__`: (String) The aforementioned salt.
- `__playable__`: (Boolean) Indicates whether this character is driven by a
  human player (a PC), or is a non-player character (NPC).


Methods:

- `interact(artifact_id, **kwargs)`


## `Location < Thing`

- `__image__`: (String) XXX NOTYET, most likely a URL


## `Artifact < Thing`

Methods:

- `interact(**kwargs)`


## `Message`

Attributes:

- `__datetime__` (String) XXX should be an integer or..?
- `__from__` (String) ID of a Character.
- `__body__` (String) the actual content of the message.
