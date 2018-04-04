class Admin::CardsController < ApplicationController

  def index 
    @takes = TakeLog.by_position
    # @takes  = TakeLog.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

  def destroy

    @take = TakeLog.find(params[:id])
    @take.destroy
   
    redirect_to admin_cards_path, notice: "刪除成功"
  end


  def sort
    params[:order].each do |key, value|
      TakeLog.find(value[:id]).update(position: value[:position])
    end
  end


end