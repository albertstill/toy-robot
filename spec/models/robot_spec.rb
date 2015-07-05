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

  describe '#move' do
    it 'moves north' do
      expect(Robot.new.place(3,3,'NORTH').move.report).to eq "3,4,NORTH"
    end
    it 'moves east' do
      expect(Robot.new.place(1,1,'EAST').move.report).to eq "2,1,EAST"
    end
    it 'moves south' do
      expect(Robot.new.place(1,1,'SOUTH').move.report).to eq "1,0,SOUTH"
    end
    it 'moves west' do
      expect(Robot.new.place(1,1,'WEST').move.report).to eq "0,1,WEST"
    end

    it 'ignores moves that would take it over a border' do
      expect(Robot.new.place(5,5,'NORTH').move.report).to eq "5,5,NORTH"
      expect(Robot.new.place(5,3,'EAST').move.report).to eq "5,3,EAST"
      expect(Robot.new.place(1,0,'SOUTH').move.report).to eq "1,0,SOUTH"
      expect(Robot.new.place(0,3,'WEST').move.report).to eq "0,3,WEST"
    end

    it 'ignores move when a successful place has not occured' do
      expect(Robot.new.move.report).to eq "The robot as not been sucessfully placed yet"
    end
  end

  describe '#left & #right' do
    let(:robot) { Robot.new.place(3,3,'NORTH') }

    it 'turns left 360 degrees / 4 times' do
      robot.left; expect(robot.report).to eq "3,3,WEST"
      robot.left; expect(robot.report).to eq "3,3,SOUTH"
      robot.left; expect(robot.report).to eq "3,3,EAST"
      robot.left; expect(robot.report).to eq "3,3,NORTH"
    end

    it 'turns right 360 degrees / 4 times' do
      robot.right; expect(robot.report).to eq "3,3,EAST"
      robot.right; expect(robot.report).to eq "3,3,SOUTH"
      robot.right; expect(robot.report).to eq "3,3,WEST"
      robot.right; expect(robot.report).to eq "3,3,NORTH"
    end
  end

  describe '#input' do
    it 'commands_1' do
      expect(Robot.new.input(File.open("./spec/fixtures/commands_1.yml")).report)
        .to eq "0,1,NORTH"
    end

    it 'commands_2' do
      expect(Robot.new.input(File.open("./spec/fixtures/commands_2.yml")).report)
        .to eq "0,0,WEST"
    end

    it 'commands_3' do
      expect(Robot.new.input(File.open("./spec/fixtures/commands_3.yml")).report)
        .to eq "3,3,NORTH"
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
