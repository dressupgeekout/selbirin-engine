require 'securerandom'

require_relative 'artifact'
require_relative 'location'
require_relative 'thing'
require_relative 'util'

module Selbirin

class Character < Thing
  THING_KIND = "Character".freeze

  #NOBODY = :__NOBODY__ # XXX see Message::NOBODY

  SALT_ATTR_KEY = "__salt__".freeze
  LOCATION_ATTR_KEY = "__location__".freeze
  PLAYABLE_ATTR_KEY = "__playable__".freeze
  HP_ATTR_KEY = "__hp__".freeze

  DEFAULT_INITIAL_HP = 10

  def initialize(**kwargs)
    super(**kwargs)
    @attrs[SALT_ATTR_KEY] = SecureRandom.base64(12)
    @attrs[LOCATION_ATTR_KEY] = Location::NOWHERE
    @attrs[PLAYABLE_ATTR_KEY] = !!kwargs[:playable] || false
    @attrs[HP_ATTR_KEY] = {
      "max" => DEFAULT_INITIAL_HP,
      "current" => DEFAULT_INITIAL_HP,
    }
  end

  def playable?
    return @attrs[PLAYABLE_ATTR_KEY]
  end

  # You are not allowed to set any attributes of the artifact if you're
  # not the owner.
  def artifact_set(id, key, value)
    art = $WORLD_SERVER.take(Util.filter(id: id))
    art["attrs"][key] = value
    $WORLD_SERVER.write(art)
  end

  # A character is not allowed to delete an artifact for which the it is not
  # the owner.
  def artifact_delete(id)
    $WORLD_SERVER.take(Util.filter(id: id)) # XXX valid operation?
  end

  # Characters can only interact with Artifacts. That's kind of the whole
  # point of Artifacts, the fact that they are interactable (unlike
  # Locations).
  #
  # May raise TypeError.
  def interact(artifact, **kwargs)
    if artifact.thing_kind != Artifact::THING_KIND
      raise(TypeError, "not an artifact: #{artifact.inspect}") 
    end
    artifact.interact(self, **kwargs)
  end
end

end # module Selbirin
