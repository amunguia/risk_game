module Risk

  module Game

    class MoveAction < Action 

        attr_reader :destination_country, :source_country, :number_armies

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
          (Board.are_adjacent?(source_country, destination_country)) &&
          (game.armies_in(source_country) >= (number_armies + 1)) &&
          (game.minimum_move <= number_armies) &&
          (game.owner_of(source_country) == game.owner_of(destination_country))
        end

    end

  end

end