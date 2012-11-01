#column_spec.rb

require_relative '../lib/column.rb'


describe Column do

  before :each do
    @column = Column.new
  end


  context '#initialize' do

    it 'is intialized to have 6 0s' do
      0.upto(5) do |num|
        @column.get_value_at(num).should eq 0
      end
    end

  end

  context '#insert' do
    it 'adds a something to an empty column' do
      @column.insert('red')
      @column.get_value_at(0).should_not eq 0
    end

    it "doesn't add to a full column" do
      @column.insert('red')
      @column.insert('black')
      @column.insert('red')
      @column.insert('black')
      @column.insert('red')
      @column.insert('black')
      expect { @column.insert('red') }.to raise_error
    end

    it "populates the column at the given place with the given marker" do
      @column.insert('red')
      @column.insert('red')
      @column.insert('red')
      @column.insert('black')
      @column.get_value_at(3).should eq 'black'
    end
  end

  context '#get_value_at' do
    it 'returns the correct value from a given space' do
      @column.insert('red')
      @column.insert('red')
      @column.insert('red')
      @column.insert('black')
      @column.get_value_at(3).should eq 'black'
    end

    it 'returns 0 from an empty space' do
      @column.get_value_at(5).should eq 0
    end

  end


end