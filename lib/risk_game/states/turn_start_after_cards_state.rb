module Risk

  module Game

    class TurnStartAfterCardsState < State 

      def allows?(action) 
        type = action.class

        type.eql? PlaceAction
      end

      def update(action, game)
        if game.max_place > 0
          self
        else
          AttackState.new
        end
      end
 
    end

  end

end