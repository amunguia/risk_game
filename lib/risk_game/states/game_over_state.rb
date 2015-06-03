module Risk

  module Game

    class GameOverState < State 

      def allows?(action)
        false
      end

      def valid_on?(game)
        false
      end

    end

  end

end