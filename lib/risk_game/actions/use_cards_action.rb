module Risk

  module Game

    class UseCardsAction < Action 

      attr_reader :by_user, :cards_to_use, :error_message

      def initialize(by_user, cards_to_use)
        @by_user = by_user
        @cards_to_use = cards_to_use
      end

      def execute_on(game)
        game.max_place += value_for_cards
        update_cards(game)
      end

      def valid_on?(game)
        if !player_has_cards(game)
          @error_message = "Attempting to play another player's cards."
        elsif value_for_cards < 2
          @error_message = "Must submit at least 2 stars."
        elsif value_for_cards > 10
          @error_message = "Cannot submit more than 10 stars at a time."
        end

        @error_message == nil
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

      def update_cards(game)
        cards = game.cards_for_player(by_user).delete_if do |card|
          cards_to_use.include? card
        end
        game.set_cards_for_player(by_user, cards)
      end

      def value_for_cards
        @value  ||= begin
          value = 0
          cards_to_use.each do |c|
            value += Cards.card_value c 
          end
          value
        end
      end
 
    end

  end

end