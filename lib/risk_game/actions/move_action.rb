module Risk

  module Game

    class MoveAction < Action 

        attr_reader :destination_country, :source_country, :number_armies, :error_message

        def initialize(source_country, destination_country, number_armies)
          @destination_country = destination_country
          @source_country = source_country
          @number_armies = number_armies
        end

        def execute_on(game)
          game.place_armies_in(destination_country, number_armies)
          game.place_armies_in(source_country, -1 * number_armies)
        end

        def valid_on?(game)
          if !Board.are_adjacent?(source_country, destination_country)
            @error_message = "Countries are not adjacent."
          elsif !(game.armies_in(source_country) >= (number_armies + 1))
            @error_message = "Number of armies is greater than #{game.armies_in(source_country) - 1}"
          elsif !(game.minimum_move <= number_armies)
            @error_message = "Number of armies is less than #{game.minimum_move}."
          elsif !(game.owner_of(source_country) == game.owner_of(destination_country))
            @error_message = "You do not own both countries."
          end

          @error_message == nil
        end

    end

  end

end