$LOAD_PATH.unshift File.join(__dir__, "..", "lib")
require 'selbirin/artifact'

class Weapon < Selbirin::Artifact
  def initialize(**kwargs)
    super(**kwargs)
    @max_damage = kwargs[:max_damage] || 50
  end

  def interact(character, **kwargs)
    super(character, **kwargs)
    other = kwargs[:other]
    damage_dealt = rand(@max_damage)
    # other.hp -= damage_dealt   # XXX doesn't work yet
    puts "#{character['__name__']} attacks #{other['__name__']} for #{damage_dealt} damage!"
  end

  def actions
    return [
      ActionSpec.new(:attack, "Attack someone!!"),
    ]
  end

  def attack(myself, other, with: weapon)
    damage_dealt = rand(@max_damage)
    # other.hp -= damage_dealt   # XXX doesn't work yet
    puts "#{myself['__name__']} attacks #{other['__name__']} for #{damage_dealt} damage!"
  end
end


=begin
class FroggerRPGWeapon < Weapon
  def attack(**kwargs)
    super
    character.morality -= 100
  end
end
=end
