module Risk::Game

  describe Board do 

    describe ".adjacent_to" do 
      it "throws an exception if the country does not exist" do 
        expect{ Board.adjacent_to :fake_country }.to raise_error(CountryDoesNotExist)
      end

      it "returns an array if the country does exist" do
        expect(Board.adjacent_to :alaska).to be_kind_of(Array)
      end

    end

    describe ".are_adjacent?" do
      it "throws an exception if the first country does not exist" do
        expect{ Board.are_adjacent?(:fake_country, :kamchatka) }.to raise_error(CountryDoesNotExist)
      end

      it "throws an exception if the second coutry does not exist" do 
        expect{ Board.are_adjacent?(:alaska, :fake_country) }.to raise_error(CountryDoesNotExist)
      end

      it "returns true if the countries are adjacent" do 
        expect( Board.are_adjacent?(:alaska, :kamchatka)).to be true
      end

      it "returns false if the countries are not adjacent" do 
        expect( Board.are_adjacent?(:alaska, :argentina)).to be false
      end
    end

    describe ".countries" do 
      it "returns an array of symbols" do 
        expect(Board.countries).to be_kind_of(Array)
      end

      it "returns an array of length 42" do 
        expect(Board.countries.length).to eq 42
      end
    end

    describe "name_for" do 
      it "throws an exception if the country does not exist" do 
        expect{ Board.name_for :fake_country }.to raise_error(CountryDoesNotExist)
      end

      it "returns an array if the country does exist" do 
        expect(Board.name_for :alaska).to be_kind_of(String)
      end 
    end

  end

end