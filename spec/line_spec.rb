require 'spec_helper'

describe Line do
  specify "add color to text" do
    message = Line.color(:blue, "Eric").color(:default, " says: ").color(:red, "hello").to_s

    expect(message).to eq("\033[34mEric\033[0m says: \033[31mhello\033[0m")
  end

  specify "use shortcuts for colors" do
    message = Line.blue("Eric").default(" says: ").red("hello").to_s

    expect(message).to eq("\033[34mEric\033[0m says: \033[31mhello\033[0m")
  end
end
