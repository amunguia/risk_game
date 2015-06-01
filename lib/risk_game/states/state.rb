module Risk

  module Game

    class State

      def allows?(action)
        raise "Abstract method."
      end

      def update(action, game)
        raise "Abstract method."
      end

    end

  end

end