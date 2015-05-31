module Risk::Game

  describe InitialPlaceState do 
    before :each do 
      @state = InitialPlaceState.new
    end

    describe ".allows?" do 
      it "returns true to PlaceAction" do
        action = PlaceAction.new(1, :kamchatka, 4)
        expect(@state.allows? action).to be true
      end

      it "returns false to any other action" do 
        action = NoMoveAction.new
        expect(@state.allows? action).to be false
      end
    end

    describe ".update" do
      before :each do 
        @game = Game.create_with_players [1,2,3,4]
        @game.max_place =  10
      end

      context "player still has more armies to place" do
        before :each do 
          @action = PlaceAction.new(1,:kamchatka, 5)
        end

        it "returns InitialPlaceState" do 
          expect(@state.update(@action, @game)).to be_kind_of(InitialPlaceState)
        end

        it "the game's current_player is unchanged" do 
          current_player = @game.current_player
          @state.update(@action, @game)
          expect(@game.current_player).to be current_player
        end
      end

      context "player has played all armies" do
        before :each do 
          @action = PlaceAction.new(1,:kamchatka, 10)
          @game.max_place = 0
        end
    
        it "the game's current_player is changed" do 
          current_player = @game.current_player
          @state.update(@action, @game)
          expect(@game.current_player).to_not be current_player
        end


        context "another player remains to place" do  
          it "returns InitialPlaceState" do 
            expect(@state.update(@action, @game)).to be_kind_of(InitialPlaceState)
          end

          it "decrements players_to_setup in game" do 
            players_left = @game.players_to_setup
            @state.update(@action, @game)
            expect(@game.players_to_setup).to be (players_left - 1)
          end
        end
        
        context "no more players remain to place" do 
          it "returns TurnStartState" do 
            @game.players_to_setup = 1
            expect(@state.update(@action, @game)).to be_kind_of(TurnStartState)
          end

        end

      end

    end

  end

end