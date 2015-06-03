module Risk::Game

  describe AttackState do 
    before :each do 
      @attack_state = AttackState.new
    end

    describe ".allows?" do 

      it "returns true for AttackAction" do 
        action = AttackAction.new(1,2, :alaska, :kamchatka, 3)
        expect(@attack_state.allows? action).to be true
      end

      it "returns true for MoveAction" do 
        action = MoveAction.new(:alaska, :kamchatka, 4)
        expect(@attack_state.allows? action).to be true
      end

      it "returns true for NoMoveAction" do
        action = NoMoveAction.new
        expect(@attack_state.allows? action).to be true
      end

      it "returns false for PlaceAction" do
        action = PlaceAction.new(1, :kamchatka, 4)
        expect(@attack_state.allows? action).to be false
      end

    end

    describe ".update" do

      context "AttackAction played" do
        before :each do 
          @action = AttackAction.new(1,2,:alaska,:kamchatka,3)
          @game = Game.new
        end

        context "attacker won" do 
          it "returns type PostAttackMoveState" do 
            @action.won = true
            expect(@attack_state.update(@action, @game)).to be_kind_of(PostAttackMoveState)
          end

          it "sets the minimum_move based on attack_with" do 
            @action.won = true
            @attack_state.update(@action, @game)
            expect(@game.minimum_move).to be 3
          end
        end

        context "attacker lost" do 
          it "returns self" do
            expect(@attack_state.update(@action, @game)).to be @attack_state
          end
        end

      end

      context "turn ended" do 

        before :each do 
          @action = MoveAction.new(1,:kamchatka, 3)
          @game = Game.create_with_players [1,2,3,4]
        end

        it "if player has won increases the number of cards by current user by 1" do 
          current_player = @game.current_player
          number_cards = @game.cards_for_player(current_player).length
          @game.won = true
          @attack_state.update(@action, @game)
          expect(@game.cards_for_player(current_player).length).to be (number_cards + 1)
        end

        it "changes the current player" do 
          current_player = @game.current_player
          @attack_state.update(@action, @game)
          expect(@game.current_player).to_not be current_player
        end

        it "sets game.won to false" do 
          @game.won = true
          @attack_state.update(@action, @game)
          expect(@game.won).to be false
        end

        it "sets max_place to number of armies next player has available" do
          allow(@game).to receive(:current_player).and_return(1)
          @game.assignment_map = {"alaska" => 1, "alberta" => 1}
          @attack_state.update(@action, @game)
          expect(@game.max_place).to be 3
        end


        context "MovedAction played" do 

          before :each do 
            @action = MoveAction.new(1,:kamchatka, 3)
          end

          it "returns type TurnStartState" do 
            expect(@attack_state.update(@action, @game)).to be_kind_of(TurnStartState)
          end
        end

        context "NoMoveAction played" do

          it "returns type TurnStartState" do
            @action = NoMoveAction.new
            expect(@attack_state.update(@action, @game)).to be_kind_of(TurnStartState)
          end
          
        end

      end

    end

  end

end