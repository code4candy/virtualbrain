# config.ru
require 'lotus'
require_relative 'application'

use Rack::Session::Cookie, secret: SecureRandom.hex(64) #setzt Cookie, wenn angemeldet 
run VirtualBrain::Application.new
