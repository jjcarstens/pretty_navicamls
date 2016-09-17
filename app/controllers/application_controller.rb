require 'pretty_navicamls/error'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
