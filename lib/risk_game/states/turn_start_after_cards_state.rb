module Risk

  module Game

    class TurnStartAfterCardsState < State 

      def allows?(action) 
        type = action.class

        type.eql? PlaceAction
      end
 
    end

  end

end