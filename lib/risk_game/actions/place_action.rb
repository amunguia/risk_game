module Risk

  module Game

    class PlaceAction < Action 

      attr_reader :by_user, :destination_country, :number_armies, :error_message

      def initialize(by_user, destination_country, number_armies)
        @by_user = by_user
        @destination_country = destination_country
        @number_armies = number_armies
      end

      def execute_on(game)
        game.place_armies_in(destination_country, number_armies)
        game.max_place -= number_armies
      end

      def valid_on?(game) 
        if !(number_armies <= game.max_place) 
          @error_message = "Sorry, you are placing too many armies."
          false
        elsif !(game.owner_of(destination_country) == by_user)
          @error_message = "Sorry, you cannot place armies into another players country."
          false
        else 
          true
        end
      end

    end

  end

end