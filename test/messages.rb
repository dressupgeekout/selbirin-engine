$LOAD_PATH.unshift File.join(__dir__, "..", "lib")
require 'selbirin'

$WORLD_SERVER = Selbirin::DatabaseConnection.new.server

me = "#{`id -un`.chomp}@#{`hostname`.chomp}"

(1...100).each do |x|
  Selbirin::Message.new(from: me, body: "this is message #{x}")
end
