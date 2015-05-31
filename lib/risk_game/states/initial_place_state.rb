module Risk

  module Game

    class InitialPlaceState < State
   
      def allows?(action)
        type = action.class

        type.eql? PlaceAction
      end

    end

  end

end