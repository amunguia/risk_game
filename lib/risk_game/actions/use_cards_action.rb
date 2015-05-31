module Risk

  module Game

    class UseCardsAction < Action 

      attr_reader :by_user, :cards_to_use

      def initialize(by_user, cards_to_use)
        @by_user = by_user
        @cards_to_use = cards_to_use
      end

      def valid_on?(game)
        player_has_cards(game)
      end

      private 

      def player_has_cards(game)
        cards = game.cards_for_player(by_user)
        cards_to_use.each do |card|
          if !cards.include? card
            return false
          end
        end
        true
      end
 
    end

  end

end