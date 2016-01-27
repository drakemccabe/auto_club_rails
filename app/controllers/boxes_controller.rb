class BoxesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

 def edit
   @box = Box.find(1)
 end

 def update
    box = Box.find(1)
      box.update(box_params)
      redirect_to root_path
 end

 def box_params
   params.require(:box).permit(:subtext, :title, :photo)
 end
end
