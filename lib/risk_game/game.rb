module Risk

  module Game

    class Game

      #The accessors are use by various game states to store
      #relevant details they need to operate.
      attr_accessor :max_place, :minimum_move

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

      def cards_for_player(player_id)
      end

      def owner_of(country)
      end

      def armies_in(country)
      end


    end

  end

end 