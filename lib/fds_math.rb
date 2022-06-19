class FDSMath
  def self.pythagoras_theorem(a,b)
    Math.sqrt(a**2 + b**2)
  end

  def self.to_degrees(radians)
    radians * (180.0/Math::PI)
  end

  def self.to_radians(degrees)
    (degrees/180.0) * Math::PI
  end

  def self.to_polar(x, y)
    [pythagoras_theorem(x,y), to_degrees(Math.atan2(y,x))]
  end

  def self.to_cartesian(radius, degrees)
    x = radius * to_degrees(Math.cos(to_radians(degrees)))
    y = radius * to_degrees(Math.sin(to_radians(degrees)))
    [x,y]
  end
end
