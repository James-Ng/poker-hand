class Hand
  attr_reader :cards

  RANKS = {
    straight_flush:  "Straight flush",
    four_of_a_kind:  "Four of a kind",
    flush:           "Flush",
    straight:        "Straight",
    three_of_a_kind: "Three of a kind",
    two_pair:        "Two pair",
    one_pair:        "One pair"
  }.freeze

  def initialize(cards)

    raise ArgumentError unless cards.count == 5
    @cards = cards.freeze
    check_duplicates

  end

  def check_duplicates
    raise "You cannt create a hand that has duplicate cards" if @cards.size != @cards.uniq { |c| [c.face, c.suit] }.size
  end

  def sort_by_face_suit
    @cards.sort_by { |c| [c.face, c.suit] }.reverse
  end

  def one_pair?
    group_face_counts.count(2) == 1
  end

  def two_pair?
    group_face_counts.count(2) == 2
  end

  def rankings
    list_rank = RANKS.map { |method, mess| mess if send :"#{method}?" }.compact
    list_rank.push(get_highest_card)
  end

  def get_highest_card
    "high card: " +  sort_by_face_suit.first.to_s
  end

  def four_of_a_kind?
    group_face_counts.include? 4
  end

  def three_of_a_kind?
    group_face_counts.include? 3
  end

  def group_by_face
    cards.group_by(&:face)
  end

  def group_face_counts
    group_by_face.values.map(&:count)
  end

  def straight_flush?
    straight? && flush?
  end

  def flush?
    suits.uniq.count == 1
  end

  def straight?
    high_straight_aces? || low_straight_aces?
  end

  def aces?
    cards.any?(&:ace?)
  end

  def high_straight_aces?
    straight_faces(faces.first) == faces
  end

  def low_straight_aces?
    aces? && straight_faces(low_ace_faces.first) == low_ace_faces
  end

  def low_ace_faces
    cards.map(&:low_ace).sort
  end

  def straight_faces(from)
    (from...from + 5).to_a
  end
  # sort faces
  def faces
    cards.map(&:face).sort
  end

  def suits
    cards.map(&:suit)
  end
end
