# PokerHand

## Installation

    $ bundle install

## Rspec

    $ rspec

Or use guard when development (auto run rspec if change code or rspec file)

    $ guard

## RuboCop

To analyze the code base.

## Build and use

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
