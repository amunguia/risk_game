module Risk

  module Game

    class Action

      def execute_on(game)
        raise "Abstract method."
      end

      def reset(game)
        game
      end

      def valid_on?(game)
        raise "Abstract method."
      end

    end

  end

end