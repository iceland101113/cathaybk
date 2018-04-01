class CardsController < ApplicationController

  before_action :authenticate_user!
  # before_action :authorize


  before_action :set_card, only: [:update, :destroy, :take]


  def index
    @cards = Card.all
    

  end
  def create
    @card = Card.new(card_params)
    if @card.save
  
      redirect_to cards_path

    else
      
      render :index
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
    @phone_number = session[:phone_number]
    @id = @phone_number["id"]
    @myphone = PhoneNumber.find_by(id: @id).phone_number
    @yournumber = TakeLog.today.find_by(ip_address: @myphone ,card_id: @card)
    unless @yournumber == nil
      ContactMailer.say_hello_to(current_user).deliver_now
      message = "您的號碼是: #{@yournumber.take_count}
                 時段: #{Card.find_by(id: @card).title}"
        TwilioTextMessenger.new(message).call
    end
    
    if @yournumber != nil
        @yournumber = @yournumber.take_count 
    end
    
    
  end


    def destroy
      
      @card.destroy
     
      redirect_to cards_path
    end

    def take
      @phone_number = session[:phone_number]
      @id = @phone_number["id"]
      @myphone = PhoneNumber.find_by(id: @id).phone_number
      @yournumber = @card.take_logs.create(ip_address: @myphone, take_count: @card.take_logs.size+1) 
     
      redirect_to cards_path
    end

  private

  def card_params
    params.require(:card).permit(:title)
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

