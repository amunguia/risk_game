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

    describe ".run_action" do 
      
    end

  end  

end