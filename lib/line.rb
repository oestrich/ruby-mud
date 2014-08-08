class Line
  COLORS = {
    :blue => "[34m",
    :white => "[00m",
    :red => "[31m",
  }

  class << self
    COLORS.keys.each do |color|
      define_method(color) do |message|
        new.color(color, message)
      end
    end
  end

  COLORS.keys.each do |color|
    define_method(color) do |message|
      color(color, message)
    end
  end

  def self.color(color, message)
    new.color(color, message)
  end

  def initialize
    @message = ""
  end

  def color(color, message)
    @message << "\033#{COLORS[color]}#{message}\033[00m"
    self
  end

  def to_s
    @message
  end
end
