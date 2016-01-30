class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  before_action :get_alerts
  before_action :set_footer
  
  def get_alerts
    @alerts = Alert.all
  end
  
  def set_footer
    @box = Box.find(1)
  end
end
