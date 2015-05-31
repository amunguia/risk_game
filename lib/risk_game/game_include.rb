module Risk

  module Game

    module GameInterface

      # Dependency: attr_accessor 'army_map', 'assignment_map', 'players'
      #     'army_map'        - Hash(Symbol => Number)
      #     'assignment_map'  - Hash(Symbol => Number)
      #     'card_list'       - String -- (List of number, comma seperated)
      #     'cards'           - Array(Number)
      #     'max_place'       - Number
      #     'minimum_move'    - Number
      #     'move_from'       - Symbol
      #     'players'         - Array(Number)
      #     'players_to_setup'- Number
      #     'state'           - State
      #     'won'             - Boolean


      INITIAL_ARMIES = 20

      def init
        self.max_place = INITIAL_ARMIES
        self.minimum_move = 0
        self.cards = {}
        self.card_list = Cards.card_list.join ","
        self.players = []
        self.players_to_setup = 0
        self.won = false
        initial_army_map
      end

      def play_action(action, game)
        if self.state.allows?(action) &&
          action.valid_on?(game)
          action.execute_on game
          self.state = state.update(action, game)
          self.state
        else
          false
        end
      end

      def armies_in(country)
        self.army_map[country]
      end

      def armies_for(player_id)
        Board.points_for self.assignment_map.select {|key, value| value == player_id}.keys
      end

      def build_assignment_map
        countries = Board.countries.shuffle
        ps = players

        assignment_map = {}
        countries.each do |country|
          assignment_map[country] = ps[0]
          ps = ps.drop(1) << ps[0]
        end

        self.assignment_map = assignment_map
      end

      def cards_for_player(player_id)
        self.cards[player_id]
      end

      def current_player
        self.players[0]
      end

      def give_player_card
        cards = cards_for_player(current_player) << next_card
        set_cards_for_player(current_player, cards)
      end

      def next_card
        array = self.card_list.split ","
        self.card_list = array.drop(1).join ","
        array[0]
      end

      def next_player
        self.players = self.players.drop(1) << self.players.first
        current_player
      end

      def owner_of(country)
        assignment_map = self.assignment_map
        player = assignment_map[country]
        self.assignment_map = assignment_map
        player
      end

      def place_armies_in(country, count)
        army_map = self.army_map
        army_map[country] += count
        self.army_map = army_map
      end

      def remove_player(player)
        players = self.players
        players.delete player 
        self.players = players
      end

      def set_cards_for_player(player_id, cards)
        saved_cards = self.cards
        saved_cards[player_id] = cards
        self.cards = saved_cards
      end

      def set_players(players)
        self.players = players
      end

      def set_owner_of(country, player)
        assignment_map = self.assignment_map
        assignment_map[country] = player
        self.assignment_map = assignment_map
      end

      private 

      def initial_army_map
        countries = Board.countries
        army_map = {}
        countries.each do |country|
          army_map[country] = 1
        end
        self.army_map = army_map
      end
 
    end 

  end

end
