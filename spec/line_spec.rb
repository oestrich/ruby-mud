require 'spec_helper'

describe Line do
  specify "add color to text" do
    message = Line.color(:blue, "Eric").color(:white, " says: ").color(:red, "hello").to_s

    expect(message).to eq("\033[34mEric\033[00m\033[00m says: \033[00m\033[31mhello\033[00m")
  end

  specify "use shortcuts for colors" do
    message = Line.blue("Eric").white(" says: ").red("hello").to_s

    expect(message).to eq("\033[34mEric\033[00m\033[00m says: \033[00m\033[31mhello\033[00m")
  end
end
