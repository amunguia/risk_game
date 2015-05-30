module Risk

  module Game

    class MoveAction < Action 

        attr_reader :destination_country, :source_country, :number_armies

        def initialize(source_country, destination_country, number_armies)
          @destination_country = destination_country
          @source_country = source_country
          @number_armies = number_armies
        end

    end

  end

end