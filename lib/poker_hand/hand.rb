# Hand class
# author @jamesnguyenvnn
class Hand
  attr_reader :cards

  RANKS = {
    straight_flush:  'Straight flush',
    four_of_a_kind:  'Four of a kind',
    flush:           'Flush',
    straight:        'Straight',
    three_of_a_kind: 'Three of a kind',
    two_pair:        'Two pair',
    one_pair:        'One pair'
  }.freeze

  def initialize(str_cards)
    @cards = build_cards_from(str_cards)
    fail ArgumentError unless @cards.count == 5
    @cards = @cards.freeze
    check_duplicates
  end

  # show all ranks of hand
  def rankings
    # use method name to call the method then map all message. Compacts (remove) all nil object
    list_rank = RANKS.map { |method, mess| mess if send :"#{method}?" }.compact
    list_rank.push(highest_card)
  end

  # check straight and flush
  def straight_flush?
    straight? && flush?
  end

  # flush if all cards have the same suit
  def flush?
    suits.uniq.count == 1
  end

  # straight : check high aces first then check low aces
  def straight?
    high_straight_aces? || low_straight_aces?
  end

  # 4 cards have the same face
  def four_of_a_kind?
    group_face_counts.include? 4
  end

  # 3 cards have the same face
  def three_of_a_kind?
    group_face_counts.include? 3
  end

  # has 2 repeated faces
  def two_pair?
    group_face_counts.count(2) == 2
  end

  # 2 cards have the same face
  def one_pair?
    group_face_counts.count(2) == 1
  end

  # highest card ( order by face and suit )
  def highest_card
    'high card: ' + sort_by_face_suit.first.to_s
  end

  private

  # build cards from string : 2h 3H 4h 8D 7s
  def build_cards_from(string)
    string.split(' ').map { |str| Card.new(str) }
  end

  # not allow to have duplicate cards
  def check_duplicates
    fail 'You cannt create a hand that has duplicate cards' if @cards.size != @cards.uniq { |c| [c.face, c.suit] }.size
  end

  # sort by face and suit
  def sort_by_face_suit
    @cards.sort_by { |c| [c.face, c.suit] }.reverse
  end

  # group face to check pair
  def group_by_face
    cards.group_by(&:face)
  end

  # count of face group
  def group_face_counts
    group_by_face.values.map(&:count)
  end

  # sort list of faces
  def faces
    cards.map(&:face).sort
  end

  # list of suits
  def suits
    cards.map(&:suit)
  end

  # check any ace in cards
  def aces?
    cards.any?(&:ace?)
  end

  # check high straight aces
  def high_straight_aces?
    straight_faces(faces.first) == faces
  end

  # if has any ace in cards then check low straight aces
  def low_straight_aces?
    aces? && straight_faces(low_ace_faces.first) == low_ace_faces
  end

  # list of faces after changing ace to low
  def low_ace_faces
    cards.map(&:low_ace).sort
  end

  # create an array from face value
  def straight_faces(from)
    (from...from + 5).to_a
  end
end
