require 'drb'
require 'rinda/tuplespace'

module Selbirin

# XXX we could theoretically use Ring/RingFinger for this, too :P
#
class DatabaseConnection
  attr_reader :host, :port, :uri, :tuple_space

  DEFAULT_HOST = "localhost".freeze
  DEFAULT_PORT = 9999

  # May raise `Errno::ECONNREFUSED`.
  def initialize(host: nil, port: nil)
    @host = host || DEFAULT_HOST
    @port = port || DEFAULT_PORT
    @uri = self.class.uri_from(host: @host, port: @port)
    DRb.start_service
    @tuple_space = DRbObject.new_with_uri(@uri)
  end

  def server
    return @tuple_space
  end

  def self.uri_from(host: nil, port: nil)
    host = DEFAULT_HOST if not host
    port = DEFAULT_PORT if not port
    return "druby://#{host}:#{port.to_s}"
  end
end

end # module Selbirin
