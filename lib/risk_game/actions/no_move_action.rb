module Risk

  module Game

    class NoMoveAction < Action 

      def valid_on?(game)
        true
      end

    end

  end

end