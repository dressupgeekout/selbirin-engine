module Selbirin

class Util
  # Convenience method around creating those TupleSpace "take" and "read"
  # filters.
  def self.filter(**kwargs)
    id = kwargs[:id]
    kind = kwargs[:kind]
    attrs = kwargs[:attrs]
    f = {"id" => id, "kind" => kind, "attrs" => attrs}
    return f
  end
end

end # module Selbirin
