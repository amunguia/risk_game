module Risk

  module Game

    module GameCreation

      def create_with_players(players_arr)
        game = self.new
        game.init
        game.set_players players_arr
        game.players_to_setup = players_arr.length

        players_arr.each do |p|
          game.set_cards_for_player(p, [])
        end

        game.build_assignment_map
        game.state = InitialPlaceState.new
        game
      end

      def play_action(user,action, game)
        error_message = allow_action(user, action, game)
        
        if !error_message
          action.execute_on game
          self.state = state.update(action, game)
          self.state
        else
          error_message
        end
      end

      private 

      def allow_action(user, action, game)
        if !game.current_player.eql? 
          "Not your turn"
        elsif game.state.allows? action
          "Cannot play this action at this time."
        elsif action.valid_on? game
          action.error_message  
        else
          true
        end
      end

    end

  end

end