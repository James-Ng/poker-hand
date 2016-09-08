class Card
  attr_reader :face, :suit
  HIGH_ACE = 14
  LOW_ACE = 1
  FACE_VALUES = {
    '2' =>  2,
    '3' =>  3,
    '4' =>  4,
    '5' =>  5,
    '6' =>  6,
    '7' =>  6,
    '8' =>  7,
    '9' =>  8,
    '10' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
  }

  SUIT_VALUES = {
    'H' => 3,
    'D' => 2,
    'C' => 1,
    'S' => 0
  }
  def initialize(str)
    raise ArgumentError, "Invalid card" if str.nil? || str.empty? || str.length == 0 || str.length > 3
    build_card(str[0...-1], str[-1,1])
  end

  def ace?
    face == HIGH_ACE
  end

  def low_ace
    ace? ? LOW_ACE : face
  end

  def to_s
    FACE_VALUES.key(face) + SUIT_VALUES.key(suit)
  end

  private
  def build_card(face, suit)
    @face  = FACE_VALUES[face.upcase]
    @suit  = SUIT_VALUES[suit.upcase]
    raise ArgumentError, "Invalid card" unless @face and @suit
  end

end
