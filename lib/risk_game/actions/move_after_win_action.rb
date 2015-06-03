module Risk

  module Game

    class MoveAfterWinAction < MoveAction 

      def valid_on?(game)
        if ! super
        elsif !(game.move_from.eql? source_country)
          @error_message = "Must move from #{game.move_from.to_s}."

        elsif !(game.move_to.eql? destination_country)
          @error_message = "Must move to #{game.move_to.to_s}."
          
        end

        @error_message == nil
      end

    end

  end

end