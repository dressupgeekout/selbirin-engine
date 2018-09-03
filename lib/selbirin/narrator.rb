module Selbirin

module Narrator
  # More like pline() or You(), it's different depending on your interface.  By
  # default, it's just a wrapper around #printf.
  def narrate(fmt, *args)
    printf(fmt+"\n", *args)
  end
end

end # module Selbirin
