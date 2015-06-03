module Risk

  module Game

    class Game 
        
      include API      

      attr_accessor :army_map, :assignment_map, :card_list, :cards, 
              :max_place, :minimum_move, :move_from, :move_to, :players, 
              :players_to_setup, :state, :won

    end

  end

end 