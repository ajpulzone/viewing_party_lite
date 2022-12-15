# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  #helper method is now accessible in the view
  #before action - every time we run an action in the controller we will run the method that

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
