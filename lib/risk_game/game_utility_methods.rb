 module Risk

  module Game

    module UtilityMethods

      #attr_reader :error_message

      INITIAL_ARMIES = 20

      def init
        self.max_place = INITIAL_ARMIES
        self.minimum_move = 0
        self.cards = {}
        self.card_list = Cards.card_list.join ","
        self.players = []
        self.players_to_setup = 0
        self.won = false
        self.state = InitialPlaceState.new
        initial_army_map
      end

      def armies_for(player_id)
        Board.points_for(self.assignment_map.select {|key, value| value == player_id}.keys)
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

      def cards_with_values_for_player(player_id)
        cards = self.cards[player_id]
        card_hash = {}
        cards.each do |card|
          card_hash[card] = Cards.card_value card
        end
        card_hash
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

      def place_armies_in(country, count)
        army_map = self.army_map
        army_map[country] += count
        self.army_map = army_map
      end 

      def play_action(user,action)
        invalid = allow_action(user, action)
        
        if !invalid
          action.execute_on self
          self.state = state.update(action, self)
          self.state
        else
          self.error_message = action.error_message
        end
      end

      def player_lose?(player)
        !self.assignment_map.values.include? player
      end

      def rolls
        @rolls || [[],[]]
      end

      def rolls=(array)
        @rolls = array
      end

      def remove_player(player)
        players = self.players
        players.delete player 
        self.players = players
      end

      def set_cards_for_player(player_id, cs)
        self.cards[player_id] = cs
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

      def allow_action(user, action)
        if !self.current_player.eql? user
          "Not your turn"
        elsif !self.state.allows? action
          "Cannot play this action at this time."
        elsif action.valid_on? self
          action.error_message  
        else
          true
        end
      end

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
