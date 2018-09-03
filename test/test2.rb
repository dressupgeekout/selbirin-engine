$LOAD_PATH.unshift File.join(__dir__, "..", "lib")
require 'selbirin'

$WORLD_SERVER = Selbirin::DatabaseConnection.new.server

id = "598380f4-cf07-4b84-a13a-c45c6c9310a2"

thing = Selbirin::Thing.get(id)
p thing

(1...100).each { |x| thing["x"] = x; thing.sync! }
