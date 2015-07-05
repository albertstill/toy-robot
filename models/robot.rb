require 'yaml'

class Robot
  @@x_min, @@x_max, @@y_min, @@y_max = 0,5,0,5
  @@orientations = %w(NORTH EAST SOUTH WEST)

  def place(x, y, orientation)
    @x, @y, @orientation = x, y, orientation if valid_position?(x,y,orientation)
    self
  end

  def move
    return self unless has_position?

    case @orientation
    when "NORTH"
      @y += 1 if valid_y?(@y+1)
    when "EAST"
      @x += 1 if valid_x?(@x+1)
    when "SOUTH"
      @y -= 1 if valid_y?(@y-1)
    when "WEST"
      @x -= 1 if valid_x?(@x-1)
    end
    self
  end

  def left
    turn(-1)
    self
  end

  def right
    turn(1)
    self
  end

  def input(yaml_commands_file)
    commands = YAML.load(yaml_commands_file)
    commands.each do |line|
      array = line.split(' ')
      method = array.first.downcase.to_sym
      if method == :place
        args = array.last.split(',')
        send(method, args[0].to_i, args[1].to_i, args[2])
      else
        send(method)
      end
    end
    self
  end

  def report
    if has_position?
      "#{@x},#{@y},#{@orientation}"
    else
      "The robot as not been sucessfully placed yet"
    end
  end

  private

  def turn(times)
    return unless has_position?
    @orientation = @@orientations[(@@orientations.index(@orientation) + times ) % @@orientations.length]
  end

  def valid_position?(x, y, orientation)
    x.is_a?(Integer) && y.is_a?(Integer) && orientation.is_a?(String) &&
    @@orientations.include?(orientation) && valid_x?(x) && valid_y?(y)
  end

  def valid_x?(x)
    x.between?(@@x_min, @@x_max)
  end

  def valid_y?(y)
    y.between?(@@y_min, @@y_max)
  end

  def has_position?
    @x != nil && @y != nil && @orientation != nil
  end
end
