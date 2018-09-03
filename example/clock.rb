$LOAD_PATH.unshift File.join(__dir__, "..", "lib")
require 'selbirin'

class Clock < Selbirin::Artifact
  def interact(character, **kwargs)
    puts "Hi #{character['__name__']}, the time is: #{Time.now}."
  end

  def actions
    return [
      ActionSpec.new(:bang, "Bang it!"),
    ]
  end

  def bang
    puts "BANG! You strike the clock hard."
  end
end
