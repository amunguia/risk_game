module Risk

  module Game

    class Game

      def self.create_with_players(players)
        game = Game.new
        game.set_players players
        game.players_to_setup = players.length

        players.each do |p|
          game.set_cards_for_player(p, [])
        end

        game.assignment_map
        game
      end

      #The accessors are use by various game states to store
      #relevant details they need to operate.
      attr_accessor :max_place, :minimum_move, :players_to_setup, :won

      def initialize
        @max_place, @minimum_move = 0, 0
        @cards = {}
        @card_list = Cards.card_list.join ","
        @players = []
        @players_to_setup = 0
        @won = false

        initial_army_map
      end

      def armies_in(country)
        @army_map[country]
      end

      def assignment_map
        countries = Board.countries.shuffle
        players = @players

        @assignment_map = {}
        countries.each do |country|
          @assignment_map[country] = players[0]
          players = players.drop(1) << players[0]
        end
      end

      def cards_for_player(player_id)
        @cards[player_id]
      end

      def current_player
        @players[0]
      end

      def give_player_card
        cards = cards_for_player(current_player) << next_card
        set_cards_for_player(current_player, cards)
      end

      def next_card
        array = @card_list.split ","
        @card_list = array.drop(1).join ","
        array[0]
      end

      def next_player
        @players = @players.drop(1) << @players.first
        current_player
      end

      def owner_of(country)
        @assignment_map[country]
      end

      def place_armies_in(country, count)
        @army_map[country] += count
      end

      def set_cards_for_player(player_id, cards)
        @cards[player_id] = cards
      end

      def set_players(players)
        @players = players
      end

      private 

      def initial_army_map
        countries = Board.countries
        @army_map = {}
        countries.each do |country|
          @army_map[country] = 1
        end
      end

    end

  end

end 