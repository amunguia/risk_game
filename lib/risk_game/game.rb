module Risk

  module Game

    class Game

      include Risk::Game::GameInterface      

      attr_accessor :army_map, :assignment_map, :card_list, :cards, 
              :max_place, :minimum_move, :players, :players_to_setup, 
              :state, :won

      def initialize
        self.init
      end

      def self.create_with_players(players)
        game = Game.new
        game.set_players players
        game.players_to_setup = players.length

        players.each do |p|
          game.set_cards_for_player(p, [])
        end

        game.build_assignment_map
        game
      end

    end

  end

end 