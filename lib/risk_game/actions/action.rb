module Risk

  module Game

    class Action

      def execute_on(game)
        raise "Abstract method."
      end

      def valid_on?(game)
        raise "Abstract method."
      end

    end

  end

end