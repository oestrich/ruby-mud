ENV["MUD_ENV"] ||= "test"

boot = File.expand_path('../../config/boot.rb', __FILE__)
load boot
