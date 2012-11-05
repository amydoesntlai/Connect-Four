require_relative 'spec_helper'

describe Column do

  before :each do
    @column = Column.new
  end


  context '#initialize' do

    it 'is intialized to have 6 dots' do
      0.upto(5) do |num|
        @column.get_value_at(num).should eq "."
      end
    end

  end

  context '#insert' do
    it 'adds a something to an empty column' do
      @column.insert("O")
      @column.get_value_at(0).should_not eq " "
    end

    it "doesn't add to a full column" do
      @column.insert("O")
      @column.insert("X")
      @column.insert("O")
      @column.insert("X")
      @column.insert("O")
      @column.insert("X")
      @column.insert("O").should be_nil
    end

    it "populates the column at the given place with the given marker" do
      @column.insert("O")
      @column.insert("O")
      @column.insert("O")
      @column.insert("X")
      @column.get_value_at(3).should eq "X"
    end
  end

  context '#get_value_at' do
    it 'returns the correct value from a given space' do
      @column.insert("O")
      @column.insert("O")
      @column.insert("O")
      @column.insert("X")
      @column.get_value_at(3).should eq "X"
    end

    it 'returns . from an empty space' do
      @column.get_value_at(5).should eq "."
    end

  end

  context '#full?' do
    it 'returns true when the column is full' do
      @column.insert("O")
      @column.insert("X")
      @column.insert("O")
      @column.insert("X")
      @column.insert("O")
      @column.insert("X")
      @column.full?.should be_true
    end

    it 'returns false when the column is not full' do
      @column.insert("O")
      @column.insert("X")
      @column.insert("O")
      @column.insert("X")
      @column.insert("O")
      @column.full?.should be_false
    end
  end

end
