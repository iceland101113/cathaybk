class Admin::CardsController < ApplicationController

  def index 
    @takes  = TakeLog.all
  end

  def destroy

    @take = TakeLog.find(params[:id])
    @take.destroy
   
    redirect_to admin_cards_path
  end


end