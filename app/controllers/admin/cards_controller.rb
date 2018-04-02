class Admin::CardsController < ApplicationController

  def index 
    @takes  = TakeLog.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

  def destroy

    @take = TakeLog.find(params[:id])
    @take.destroy
   
    redirect_to admin_cards_path
  end


end