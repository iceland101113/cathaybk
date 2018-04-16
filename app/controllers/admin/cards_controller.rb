class Admin::CardsController < ApplicationController

  def index 
    # @takes = TakeLog.includes(:card).by_position
     @takes  = TakeLog.includes(:card).by_position
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

  def remind
    

    @take = TakeLog.find(params[:id])
   
    @phone_number = @take.ip_address.to_i 
    message = "您是: #{@take.take_count}號,
              時段: #{Card.find_by(id: @take.card_id).title},日期: #{Card.find_by(id: @take.card_id).date},
              預計十分鐘後輪到你,可以往分行出發囉！"
    ContactMailer.say_remind_to(current_phone, message).deliver_now
    
    @take.update(status: 1)
    redirect_to admin_cards_path, notice: "提醒成功"
  end
  


end