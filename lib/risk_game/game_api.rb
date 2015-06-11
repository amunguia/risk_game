module Risk

  module Game

    # When including, ensure the following attr_accessors are provided
    #     'army_map'        - Hash(Symbol => Number)
    #     'assignment_map'  - Hash(Symbol => Number)
    #     'card_list'       - String 
    #     'cards'           - Hash(Number => Array(Number))
    #     'max_place'       - Number
    #     'minimum_move'    - Number
    #     'move_from'       - Symbol
    #     'move_to'         - Symbol
    #     'players'         - Array(Number)
    #     'players_to_setup'- Number
    #     'state'           - State
    #     'won'             - Boolean

    module API
      
      include UtilityMethods

      module CreateGame
          
        def create_with_players(players_arr)
          game = self.new
          game.init
          game.set_players players_arr
          game.players_to_setup = players_arr.length

          players_arr.each do |p|
            game.set_cards_for_player(p, [])
          end
          
          game.build_assignment_map  
          game
        end

      end
      
      def attack(attacker, attacking_country, defending_country, attack_with)
        self.play_action(attacker, AttackAction.new(attacker, self.owner_of(defending_country), 
                   attacking_country, defending_country, attack_with))
      end

      def armies_in(country)
        self.army_map[country]
      end

      def current_player
        self.players[0]
      end

      def game_over?
        self.state.class.eql? GameOverState
      end

      def move(mover, move_from, move_to, num_armies)
        self.play_action(mover, MoveAction.new(move_from, move_to, num_armies))
      end

      def no_move(no_mover)
        self.play_action(no_mover, NoMoveAction.new)
      end

      def owner_of(country)
        assignment_map = self.assignment_map
        player = assignment_map[country]
        self.assignment_map = assignment_map
        player
      end

      def place(placer, into_country, number_armies)
        self.play_action(placer, PlaceAction.new(placer, into_country, number_armies))
      end

      def use_cards(user, cards_array)
        self.play_action(user, UseCardsAction.new(user, cards_array))
      end

      def self.included(klass)
        klass.extend(CreateGame)
      end

    end

  end

end