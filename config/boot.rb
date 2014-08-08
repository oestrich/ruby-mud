ENV["MUD_ENV"] ||= "development"

lib = File.expand_path('../../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Bundler.setup(:default, ENV["MUD_ENV"])

require 'ruby-mud'
