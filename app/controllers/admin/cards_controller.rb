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


  def remind
    @take = TakeLog.find(params[:id])
    @phone_number = @take.ip_address.to_i 
    message = "您是: #{@take.take_count}號
              時段: #{Card.find_by(id: @take.card_id).title}
              預計十分鐘後輪到你,可以往分行出發囉！"
    client = Twilio::REST::Client.new
    client.messages.create({
      from: Rails.application.secrets.twilio_phone_number,
      to: "+886#{@phone_number}",
      body: message
    })
    redirect_to admin_cards_path, notice: "提醒成功"
  end


end