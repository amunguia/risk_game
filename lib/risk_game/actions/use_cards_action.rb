module Risk

  module Game

    class UseCardsAction < Action 

      attr_reader :by_user, :cards_to_use

      def initialize(by_user, cards_to_use)
        @by_user = by_user
        @cards_to_use = cards_to_use
      end

    end

  end

end