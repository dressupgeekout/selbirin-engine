$LOAD_PATH.unshift File.join(__dir__, "..", "lib")
require 'selbirin'

class Clock < Selbirin::Artifact
  def actions
    return [
      ActionSpec.new(:bang, "Bang it!"),
    ]
  end

  def bang
    puts "BANG! You strike the clock hard."
  end
end
