class Card

  attr_reader :suit # I got read of the attr_reader for value
                    # bc I need to define a method
                    # to account for face cards

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def value
    if @value.is_a?(Fixnum)
      @value
    elsif @value == :ace
      11
    else
      10
    end
  end
end

class Deck

  #attr_reader :cards don't need this anymore with methods using @cards

  def initialize
    @cards = [ :hearts, :diamonds, :clubs, :spades ].map do |suit|
      ((2..10).to_a + [ :jack, :queen, :king, :ace ]).map do |value|
        Card.new(value, suit)
      end
    end.flatten.shuffle
  end

  def length
    @cards.length
  end

  def [](index)
    @cards[index]
  end

  def deal(n)
    @cards.shift(n)
  end
end

class Blackjack

  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new(@deck.deal(2))
    @dealer = @deck.deal(2)
  end

  def dealer_hand
    @dealer # I'm not at all happy with this method, but it works
  end
end

class Player

  attr_reader :hand # yes, reader, even though I'll change it during the game

  def initialize(cards = []) # default value just a placeholder bc I
                             # lazily don't want to change Player.new
                             # in tests
    @hand = cards 
  end

  def take(card)
    @hand << card
  end

  def hand_value
    @hand.inject(0){|sum, card| sum + card.value }
  end
end