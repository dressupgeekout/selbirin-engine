$LOAD_PATH.unshift File.join(__dir__, "..", "lib")
require 'selbirin'

class Bomb < Selbirin::Artifact
  def initialize(**kwargs)
    super(**kwargs)
    @tries = 3
  end

  def interact(character, **kwargs)
    super(character, **kwargs)
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
