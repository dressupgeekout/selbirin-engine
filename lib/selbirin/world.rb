require 'fileutils'

module Selbirin

# The World is a 'module' of all the code that's needed in order to properly
# load a database.
class World
  attr_reader :name

  DEFAULT_NAME = "Default"

  def initialize(name: DEFAULT_NAME)
    @name = name
    FileUtils.mkdir_p(dir)
  end

  def dir
    return File.expand_path("~/.cache/rpg/worlds/#{@name}")
  end
end

end # module Selbirin
