require_relative 'thing'

module Selbirin

class Location < Thing
  THING_KIND = "Location".freeze

  # A special pseudo-location which primarily indicates that a user is
  # offline.
  NOWHERE = :__NOWHERE__
end

end # module Selbirin
