module Risk

  module Game

    class PlaceAction < Action 

      attr_reader :by_user, :number_armies

      def initialize(by_user, number_armies)
        @by_user = by_user
        @number_armies = number_armies
      end

    end

  end

end