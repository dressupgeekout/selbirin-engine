require 'securerandom'

module Selbirin

# Unlike ordinary Things, creating a Message *implies* that it is going to
# be sent immediately. Also, there is no such notion as being able to
# "update" a message. Messages are also given explicit lifetimes.
class Message
  THING_KIND = "Message".freeze
  MESSAGE_LIFETIME = 3 * 60  # 3 minutes

  # XXX this should be defined in Character but otherwise we get :
  #
  #     uninitialized constant Thing (NameError)
  #
  NOBODY = :__NOBODY__

  attr_reader :from, :body, :server

  def initialize(from: nil, body: nil, server: nil)
    @from = from
    @body = body
    @server = $WORLD_SERVER || server # || complain
    @server.write({
      "id" => SecureRandom.uuid,
      "kind" => THING_KIND,
      "attrs" => {
        "__datetime__" => Time.now.to_s,
        "__from__" => @from,
        "__body__" => @body,
      },
    }, MESSAGE_LIFETIME)
  end

  def self.announcement(fmt, *args)
    self.new(from: NOBODY, body: sprintf(fmt, *args))
  end
end

end # module Selbirin
