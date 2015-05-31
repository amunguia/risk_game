module Risk

  module Game

    class TurnStartState < State 

      def allows?(action)
        type = action.class

        (type.eql? PlaceAction) ||
        (type.eql? UseCardsAction)
      end

      def update(action, game)
        case action.class.to_s
        when "Risk::Game::UseCardsAction"
          TurnStartAfterCardsState.new
        else
          if game.max_place > 0
            self
          else
            AttackState.new
          end
        end
      end

    end

  end

end