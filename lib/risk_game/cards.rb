module Risk

  module Game

    module Cards

      def self.card_list
        @cards.keys.shuffle
      end

      def self.card_value(card)
        if @cards.keys.include? card
          @cards[card]
        else
          raise NotACard
        end
      end

      def self.is_a_card?(card)
        @cards.keys.include? card
      end

      private 

      def self.build_cards
        @cards = {
            "Western United States" => 1,
            "Brazil" => 1,
            "Ontario" => 2,
            "Central America" => 1,
            "South Africa" => 1,
            "Yakutsk" => 2,
            "Western Australia" => 1,
            "Congo" => 2,
            "Argentina" => 1,
            "Afghanistan" => 2,
            "Irkutsk" => 2,
            "India" => 1,
            "Eastern Australia" => 1,
            "Kamchatka" => 1,
            "Greenland" => 1,
            "Peru" => 1,
            "Siberia" => 2,
            "Northwest Territory" => 1,
            "Alberta" => 1,
            "Siam" => 1,
            "Indonesia" => 1,
            "Ontario" => 1,
            "Mongolia" => 2,
            "Northern Europe" => 2,
            "North Africa" => 2,
            "China" => 1,
            "Scandanavia" => 1,
            "Iceland" => 1,
            "Middle East" => 1,
            "Venezuela" => 1,
            "Great Britain" => 1,
            "Japan" => 1,
            "Southern Europe" => 2,
            "Eastern United States" => 1,
            "Alaska" => 1,
            "Madagascar" => 1,
            "Ukraine" => 2,
            "Egypt" => 1, 
            "East Africa" => 1,
            "New Guinea" => 1,
            "Ural" => 2,
            "Western Europe" => 2,
            "Quebec" => 1
        }
      end

      build_cards
    end

  end

end