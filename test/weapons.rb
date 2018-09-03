$LOAD_PATH.unshift File.join(__dir__, "..", "lib")
require 'selbirin'

$LOAD_PATH.unshift File.join(__dir__, "..", "example")
require 'weapon'

$WORLD_SERVER = Selbirin::DatabaseConnection.new.server

haley = Selbirin::Character.new(attrs: {
  "__name__" => "Haley",
})
haley.sync!

molly = Selbirin::Character.new(attrs: {
  "__name__" => "Molly",
})
molly.sync!

sword = Weapon.new(attrs: {
  "__name__" => "Cool Sword",
})
sword.sync!

5.times {
  haley.interact(sword, other: molly)
}
