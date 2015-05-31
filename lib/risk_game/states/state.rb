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

      def update_state

      end

    end

  end

end