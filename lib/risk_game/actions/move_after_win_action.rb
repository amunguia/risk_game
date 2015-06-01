module Risk

  module Game

    class MoveAfterWinAction < MoveAction 

      def valid_on?(game)
        if super
          (game.move_from.eql? source_country) &&
          (game.move_to.eq? destination_country)
        else
          false
        end
      end

    end

  end

end