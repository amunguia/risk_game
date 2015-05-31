module Risk

  module Game

    class TurnStartState < State 

      def allows?(action)
        type = action.class

        (type.eql? PlaceAction) ||
        (type.eql? UseCardsAction)
      end

    end

  end

end