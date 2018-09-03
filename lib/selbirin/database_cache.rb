require 'fileutils'
require 'pstore'

module Selbirin

# At this point, this is class is essentially a wrapper around PStore.
class DatabaseCache
  DEFAULT_PATH = File.expand_path("~/.cache/rpg/data.pstore") # XXX

  attr_reader :store

  def initialize(at: nil)
    @path = at || DEFAULT_PATH
    FileUtils.mkdir_p(File.dirname(@path))
    @store = PStore.new(@path)
  end

  # We expect a Hash.
  def commit(thing_h)
    @store.transaction do
      @store[thing_h["id"]] = thing_h
    end
  end

  # Accepts any Enumerable.
  def commit_collection(collection)
    @store.transaction do
      collection.each { |thing_h| commit(thing_h) }
    end
  end

  def remove(id)
    @store.transaction { @store.delete(id) }
  end

  def all_ids
    @store.transaction { return @store.roots }
  end

  def get(id)
    @store.transaction { return @store[id] }
  end
end

end # module Selbirin
