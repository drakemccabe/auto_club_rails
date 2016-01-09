class AlertsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
   def new
     @alert = Alert.new
  end

  def create
    new_alert = Alert.new(alert_params)

    if new_alert.save
      redirect_to root_path
    else
      flash[:error] = new_alert.errors.full_messages.join(", ")
      redirect_to root_path
    end
  end
  
  def alert_params
    params.require(:alert).permit(:body, :exp_date)
  end
end