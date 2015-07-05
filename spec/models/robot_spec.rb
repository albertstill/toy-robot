require 'spec_helper'

describe Robot do

  describe '#place' do
    it 'sets a valid place' do
      expect(Robot.new.place(3,3,'NORTH').report).to eq "3,3,NORTH"
    end
    it 'does not set a position for an invalid place' do
      expect(Robot.new.place(7,3,'NORTH').report).to eq "The robot as not been sucessfully placed yet"
    end
  end

  
  describe '#valid_position?' do
    describe 'invalid examples' do
      it 'only accepts integers' do
        expect(Robot.new.send(:valid_position?,1.1,2,'NORTH')).to be false
      end
      it 'only accepts string cardinal values' do
        expect(Robot.new.send(:valid_position?,1,2,1)).to be false
      end
      it 'only accepts capitalised cardinal directions' do
        expect(Robot.new.send(:valid_position?,1,2,'north')).to be false
      end
      it 'only accepts y cooridinates within 0 to 5' do
        expect(Robot.new.send(:valid_position?,1,6,'EAST')).to be false
      end
      it 'only accepts x cooridinates within 0 to 5' do
        expect(Robot.new.send(:valid_position?,-1,5,'EAST')).to be false
      end
    end

    describe 'valid examples' do
      it 'at origin facing west' do
        expect(Robot.new.send(:valid_position?,0,0,'WEST')).to be true
      end
      it 'at the top right corner facing north' do
        expect(Robot.new.send(:valid_position?,5,5,'NORTH')).to be true
      end
      it 'in the middle facing south' do
        expect(Robot.new.send(:valid_position?,2,2,'SOUTH')).to be true
      end
    end
  end

  it '#valid_x?' do
    expect(Robot.new.send(:valid_x?, -1)).to be false
    expect(Robot.new.send(:valid_x?, 0)).to be true
    expect(Robot.new.send(:valid_x?, 3)).to be true
    expect(Robot.new.send(:valid_x?, 5)).to be true
    expect(Robot.new.send(:valid_x?, 6)).to be false
  end

  it '#valid_y?' do
    expect(Robot.new.send(:valid_y?, -1)).to be false
    expect(Robot.new.send(:valid_y?, 0)).to be true
    expect(Robot.new.send(:valid_y?, 3)).to be true
    expect(Robot.new.send(:valid_y?, 5)).to be true
    expect(Robot.new.send(:valid_y?, 6)).to be false
  end

  it '#has_position?' do
    expect(Robot.new.place(3,3,'NORTH').send(:has_position?)).to be true
    expect(Robot.new.place(3,6,'NORTH').send(:has_position?)).to be false
  end
end
