module Risk

  module Game

    class NoMoveAction < Action 
    
      

      def execute_on(game)
        "ended turn."
      end

      def valid_on?(game)
        true
      end

    end

  end

end