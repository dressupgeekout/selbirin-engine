$LOAD_PATH.unshift File.join(__dir__, "..", "lib")
require 'selbirin'

class Bomb < Selbirin::Artifact
  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    @tries = 3
  end

  def actions
    return [
      ActionSpec.new(:touch, "Interact with it.")
    ]
  end

  def touch(character, **kwargs)
    if @tries > 0
      announce("Seems okay.")
      @tries = @tries - 1
      sync!
    else
      announce("**BOOM** !!!!")
      destroy!
      # character.gets_hurt ?
    end
  end
end
