class CardsController < ApplicationController

  # before_action :authenticate_user!
  # before_action :authorize
  before_action :set_card, only: [:update, :destroy, :take]

  def index
    @card = Card.new
    # current_user.update(phone: current_phone.phone_number)
  end

  def create
    @card = Card.new(card_params)
    @people = Card.where("title >= ? AND  date >= ?", @card.title  , @card.date).size
    if @people > 6
      redirect_to cards_path, notice: "時段額滿"
    else 
      if @card.save
        @yournumber = @card.take_logs.create(ip_address: current_phone.phone_number, take_count: @card.id) 
          unless @yournumber == nil
          message = "您的號碼是: #{@yournumber.take_count},
                   時段: #{@card.title},
                   日期: #{@card.date}"
        # @phone.send_message(current_phone.phone_number, message)
          ContactMailer.say_hello_to(current_phone,message).deliver_now
          end
        redirect_to card_path(@card.id), notice: "預約成功,請看簡訊或者信箱"
    
    
      else
        render :index, notice: "預約失敗"
      end
     end 
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else     
      render :index
    end
  end

  def show
    @cards = Card.all
    @card = Card.find(params[:id])
    @yournumber = TakeLog.find_by(ip_address: current_phone.phone_number ,card_id: @card)
    @people = Card.where("title >= ? AND  date >= ?", @card.title  , @card.date).size
   
    # if @people.over?
    #   redirect_to cards_path, notice: "時段額滿"
    # end

    if @yournumber != nil
        @yournumber = @yournumber.take_count 
    end    
  end

  def destroy
    @card.destroy
    redirect_to cards_path, notice: "刪除成功"
  end

  # def take
  #    @phone_number = session[:phone_number]
  #     @id = @phone_number["id"]
  #     @myphone = PhoneNumber.find_by(id: @id).phone_number
  #     @yournumber = @card.take_logs.create(ip_address: @myphone, take_count: @card.take_logs.size+1) 
  #     unless @yournumber == nil
        

  #       message = "您的號碼是: #{@yournumber.take_count}
  #                  時段: #{Card.find_by(id: @card).title}"
  #       # ContactMailer.say_hello_to(current_user,message).deliver_now
  #       TwilioTextMessenger.new(message).call
  #     end
  #     redirect_to cards_path, notice: "預約成功,請看簡訊或者信箱"
  #   end

  private

  def card_params
    params.require(:card).permit(:title, :date)
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def authorize
    if session[:phone_number] == nil
      redirect_to root_path, notice: "請電話驗證"
    end
  end
end