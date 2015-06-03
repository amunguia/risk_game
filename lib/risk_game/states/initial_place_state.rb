module Risk

  module Game

    class InitialPlaceState < State
   
      def allows?(action)
        type = action.class
        if type.eql? PlaceAction
          true
        else
          puts type
          false
        end
      end

      def update(action, game)
        if game.max_place > 0
          InitialPlaceState.new
        else
          game.next_player
          game.players_to_setup -= 1
          game.max_place = next_max_place(game)
          
          if game.players_to_setup > 0
            InitialPlaceState.new
          else
            TurnStartState.new
          end
        end
      end

      def next_max_place(game) 
        if game.players_to_setup > 0
          Game::INITIAL_ARMIES
        else
          game.armies_for game.current_player
        end
      end

    end

  end

end