# PokerHand

This is a simple gem that I make for trying to apply TDD and best practices. 
The suit order is : 

    SUIT_VALUES = {
        'H' => 3,
        'D' => 2,
        'C' => 1,
        'S' => 0
    }

The face values are : 

    FACE_VALUES = {
        '2' =>  2,
        '3' =>  3,
        '4' =>  4,
        '5' =>  5,
        '6' =>  6,
        '7' =>  7,
        '8' =>  8,
        '9' =>  9,
        '10' => 10,
        'J' => 11,
        'Q' => 12,
        'K' => 13,
        'A' => 14
     }
  
 The gem provides some methods that help to check the hand of cards or show all hand categories of the cards.
   
    $ irb
    > require 'poker_hand'
    > hand = Hand.new("as ad ah ac 7s")
    > hand.rankings        # show all hand categories
    => ["Four of a kind", "high card: AH"]
    > hand.two_pair?       # check two_pair? hand
    => false  
    

## Rspec

    $ rspec

Or use guard when development (auto run rspec if change code or rspec file)

    $ guard

## RuboCop

To analyze the code base.

## Build and install

    $ gem build poker_hand.gemspec
    
It will build the gem ( the output is `poker_hand-0.1.0.gem`), install it : 

    $ gem install poker_hand-0.1.0.gem
    
Then you can use `irb` to play it 

    $ irb
    > require 'poker_hand'
    > hand = Hand.new("as 10d 9h 6c 7s")
    > hand.rankings
    => ["high card: AS"]

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/james-ng/poker_hand.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
