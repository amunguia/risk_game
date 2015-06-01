module Risk

  module Game

    module GameCreation

      def create_with_players(players_arr)
        game = Game.new
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

    end

  end

end