module Risk

  module Game

    # When including, ensure the following attr_accessors are provided
    #     'army_map'        - Hash(Symbol => Number)
    #     'assignment_map'  - Hash(Symbol => Number)
    #     'card_list'       - String 
    #     'cards'           - Array(Number)
    #     'max_place'       - Number
    #     'minimum_move'    - Number
    #     'move_from'       - Symbol
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
          game.state = InitialPlaceState.new
          game
        end

      end
      
      def attack(attacker, attacking_country, defending_country, attack_with)

      end

      def move(mover, move_from, move_to)

      end

      def no_move

      end

      def place(placer, into_country, number_armies)

      end

      def use_cards(user, cards_array)

      end

      def self.included(klass)
        klass.extend(CreateGame)
        klass.extend(PlayGame)
      end

      private 

        module PlayGame 

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

        end

    end

  end

end