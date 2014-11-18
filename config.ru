# config.ru
require 'lotus'
require_relative 'application'

run VirtualBrain::Application.new
