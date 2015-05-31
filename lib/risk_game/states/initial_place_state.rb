module Risk

  module Game

    class InitialPlaceState < State
   
      def allows?(action)
        type = action.class
        type.eql? PlaceAction
      end

      def update(action, game)
        if game.max_place > 0
          InitialPlaceState.new
        else
          game.next_player
          game.players_to_setup -= 1
          game.max_place = Game::INITIAL_ARMIES
          
          if game.players_to_setup > 0
            InitialPlaceState.new
          else
            TurnStartState.new
          end
        end
      end

    end

  end

end