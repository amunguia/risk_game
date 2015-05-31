module Risk

  module Game

    class State

      def allows?(action)
        raise "Abstract method."
      end

      def run_action(action, game)
        result = action.execute_on game
        if result 
          update_state(action, game)
        else
          self
        end
      end

      def play(action, game)
        if self.allows?(action) &&
            action.valid_on?(game)
          action.execute_on game
          game.update_state self.update(action)
        else
          false
        end
      end 

      def update(action, game)
        raise "Abstract method."
      end

    end

  end

end