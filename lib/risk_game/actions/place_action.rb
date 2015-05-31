module Risk

  module Game

    class PlaceAction < Action 

      attr_reader :by_user, :destination_country, :number_armies

      def initialize(by_user, destination_country, number_armies)
        @by_user = by_user
        @destination_country = destination_country
        @number_armies = number_armies
      end

      def execute_on(game)
        game.place_armies_in(destination_country, number_armies)
        true
      end

      def reset(game)
        game.max_place = 0
        game
      end

      def valid_on?(game) 
        (number_armies <= game.max_place) &&
        (game.owner_of(destination_country) == by_user)
      end

    end

  end

end