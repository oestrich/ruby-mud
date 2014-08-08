class Line
  COLORS = {
    :black => "[30m",
    :red => "[31m",
    :green => "[32m",
    :yellow => "[33m",
    :blue => "[34m",
    :magenta => "[35m",
    :cyan => "[36m",
    :light_gray => "[37m",
    :dark_gray => "[90m",
    :light_red => "[91m",
    :light_green => "[92m",
    :light_yellow => "[93m",
    :light_blue => "[94m",
    :light_magenta => "[95m",
    :light_cyan => "[96m",
    :white => "[97m",
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
    if COLORS.keys.include?(color)
      @message << "\033#{COLORS[color]}#{message}"
    else
      @message << "\033[0m#{message}"
    end
    self
  end

  def default(message)
    @message << "\033[0m#{message}"
    self
  end

  def to_s
    "#{@message}\033[0m"
  end
end
