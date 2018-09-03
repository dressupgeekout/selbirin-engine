require 'json'
require 'securerandom'
require 'yaml'

require_relative 'message'
require_relative 'util'

module Selbirin

# XXX is there really a need for ::NONE?
module SyncMethod
  CREATE = :create
  UPDATE = :update
  NONE = nil
end

class UnknownIDError < RuntimeError
end

class Thing
  attr_accessor :attrs
  attr_reader :id
  attr_reader :server

  THING_KIND = "Generic".freeze

  CLASS_ATTR_KEY = "__class__".freeze
  DESCR_ATTR_KEY = "__descr__".freeze
  NAME_ATTR_KEY = "__name__".freeze
  CREATETIME_ATTR_KEY = "__createtime__".freeze # XXX or just use mtime?? or both?

  # Creates a new Thing. The new Thing is NOT automatically synced to the
  # server.
  #
  # The following kwargs are recognized:
  # - `db_connection`, which is a DatabaseConnection. Default: `$WORLD_SERVER`.
  def initialize(attrs: nil, **kwargs)
    @id = SecureRandom.uuid
    @attrs = {
      CLASS_ATTR_KEY => self.class.name,
      CREATETIME_ATTR_KEY => Time.now,
    }
    @attrs.merge!(attrs) if attrs
    @sync_method = SyncMethod::CREATE
    @world_server = kwargs[:db_connection]&.server || $WORLD_SERVER # XXX || complain
  end

  # May raise Psych::SyntaxError.
  def self.from_yaml(string)
    thing = self.new
    thing.attrs = YAML.load(string)
    thing.instance_variable_set(:@sync_method, SyncMethod::UPDATE)
    return thing
  end

  # May raise Psych::SyntaxError.
  def self.from_yaml_file(path)
    return self.from_yaml(File.read(path))
  end

  # We unconditionally set the sync_method to "update" since, clearly, this
  # object has already been created.
  def self.get(id)
    thing = self.new
    kind = self.const_get("THING_KIND")
    if (obj = self.id_ok?(id)).nil?
      raise(UnknownIDError, "no such #{kind} with ID #{id}")
    end
    thing.instance_variable_set(:@id, obj["id"])
    thing.instance_variable_set(:@sync_method, SyncMethod::UPDATE)
    thing.attrs = obj["attrs"]
    return thing
  end

  # Seems lame that we have to read_all in order to find things out...
  # XXX barf
  #
  # XXX should have an internal reference to the world server, rather than
  # this special global ref >:|
  def self.id_ok?(id)
    return $WORLD_SERVER.read_all(Util.filter(id: id)).first
  end

  # XXX i think this is forcing my hand to have "kind" and "subkind" BOTH be on the top level...
  # otherwise, i'll just drill down further past (ugh)
  def self.all
    @world_server.read_all(Util.filter(kind: self.const_get("THING_KIND")))
  end

  # Returns the name attribute.
  def name
    return @attrs[NAME_ATTR_KEY]
  end

  # Returns the description attribute.
  def describe
    return @attrs[DESCR_ATTR_KEY]
  end

  # Assigns the attribute caled `key` to the given value. The updated object is
  # NOT synced to the server.
  def set(key, value)
    # Prevents us from blocking forever by waiting to "take" an object for
    # updating that hasn't already been created (in #sync!).
    @sync_method = SyncMethod::UPDATE if @sync_method != SyncMethod::CREATE
    @attrs[key] = value
  end
  alias_method :[]=, :set

  # Assigns the attribute called `key` to the given value and automatically
  # sync the updated Thing to the server.
  def set!(key, value)
    set(key, value)
    sync!
  end

  # Retrieves the value for the given attribute. This method always returns the
  # "local" data, even if that includes "pending" or "unsynced" changes.
  def get(key)
    return @attrs[key]
  end
  alias_method :[], :get

  # Commits all pending changes for this Thing to the server. Returns `self`.
  def sync!
    if @sync_method == SyncMethod::UPDATE
      @world_server.take(Util.filter(id: @id, kind: thing_kind))
    end
    @world_server.write(Util.filter(id: @id, kind: thing_kind, attrs: @attrs))
    if @sync_method == SyncMethod::CREATE
      Message.announcement("NEW %s %p CREATED", self.class.name, @attrs["__name__"])
    end
    @sync_method = SyncMethod::UPDATE
    return self
  end

  # May raise `UnknownIDError`.
  def destroy!
    if self.class.id_ok?(@id)
      @world_server.take(Util.filter(id: @id))
    else
      raise(UnknownIDError, "can't destroy nonexistent object #{@id}")
    end
  end

  # A "dynamic" version of ::THING_KIND. Seems to be necessary with
  # subclasses. (XXX maybe just use a class variable instead?)
  def thing_kind
    return self.class.const_get("THING_KIND")
  end

  def to_hash
    return {
      "id" => @id,
      "kind" => thing_kind,
      "attrs" => @attrs,
    }
  end
  alias_method :to_h, :to_hash

  def to_json
    return JSON.dump(self.to_hash)
  end

  def to_yaml
    return YAML.dump(self.to_hash)
  end

  # This mainly provides a syntactic sugar to let us easily drill down into
  # an object's attributes.
  def method_missing(meth)
    valid_attr = @attrs[meth.to_s]
    if valid_attr
      return valid_attr
    else
      raise(NoMethodError, "undefined method `#{meth}' for #{self}")
    end
  end
end

end # module Selbirin
