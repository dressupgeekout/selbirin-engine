$LOAD_PATH.unshift File.join(__dir__, "..", "lib")
require 'selbirin'

$WORLD_SERVER = Selbirin::DatabaseConnection.new.server

Selbirin::Thing.new.sync!

class Plaything < Selbirin::Thing
end

ball = Plaything.new
ball["__name__"] = "Charlotte's Beach Ball"
ball["__descr__"] = "It's charlotte's beach ball and that's all there is to it"
ball.sync!

class Pet < Selbirin::Thing
end

dog = Pet.new(attrs: {
  "__name__" => "Marshal",
  "__descr__" => "he's my dog and he's amazing",
  "age" => 4,
  "puppyStatus" => "very much a puppy",
})

dog.sync!
