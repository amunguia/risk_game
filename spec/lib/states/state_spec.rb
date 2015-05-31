module Risk::Game

  describe State do 
    before :each do
      @state = State.new
    end

    describe ".allows?" do 
      it "returns error becuase this method is abstract." do
         expect{ @state.allows? NoMoveAction.new }.to raise_error "Abstract method."
      end
    end

    describe ".update" do
      it "returns error because this method is abstract." do 
        expect{ @state.update NoMoveAction.new, Game.new}.to raise_error "Abstract method."
      end
    end

  end  

end