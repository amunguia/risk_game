module Risk

  module Game

    class Game

      #The accessors are use by various game states to store
      #relevant details they need to operate.
      attr_accessor :max_place, :minimum_move

      def initialize
        @max_place, @minimum_move = 0, 0
        @cards = {}
        initial_army_map
      end


      #not to be included in this class!
      def play_turn(action)
        #if state.allows(action) &&            # Does the state allow this action type
        #   action.valid_on?(self)             # Is the action valid on this game
        #  state.play(self, action.execute_on self)  # Play the action, state takes result and
                                              # and determine if the state should change.
                                              # Return state.
        #else
        #  state
        #end
      end


      def armies_in(country)
        @army_map[country]
      end

      def cards_for_player(player_id)
      end

      def owner_of(country)
      end

      def place_armies_in(country, count)
        @army_map[country] += count
      end

      def set_cards_for_player(player_id, cards)
        @cards[player_id] = cards
      end

      def initial_army_map
        countries = Board.countries
        @army_map = {}
        countries.each do |country|
          @army_map[country] = 0
        end
      end

    end

  end

end 