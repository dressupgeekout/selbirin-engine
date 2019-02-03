require_relative 'thing'

module Selbirin

class ActionSpec < Struct.new(:id, :name)
end

# Artifacts are Things that can be owned by Character.
class Artifact < Thing
  THING_KIND = "Artifact".freeze

  attr_accessor :owner

  # XXX
  def assert_owner
    raise("no owner???") if not @attrs["__owner__"]
    filter = {"id" => @attrs["__owner__"], "class" => "Character", @attrs => nil}
    if $world_server.read_all(filter).empty?
      raise("this artifact is owned by an invalid character id?")
    end
  end

  # Does nothing by default; users are encouraged to subclass Artifact and
  # allow for cool interactivity.
  def interact(character, **kwargs)
    return nil
  end

  # Script writers are expected to return an Array which contains _n_
  # ActionSpecs.
  def actions
    return []
  end

  def list_actions
    actions.each do |actionspec|
      puts "- #{actionspec.name}"
    end
  end
end

end # module Selbirin
