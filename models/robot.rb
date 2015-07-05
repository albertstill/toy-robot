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
  def report
    if has_position?
      "#{@x},#{@y},#{@orientation}"
    else
      "The robot as not been sucessfully placed yet"
    end
  end

  private

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
