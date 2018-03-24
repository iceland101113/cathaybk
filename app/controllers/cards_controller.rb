class CardsController < ApplicationController





 before_action :set_card, only: [:update, :destroy, :show, :take]


  def index
    @cards = Card.all

    if params[:id]
      set_card
    else
      @card = Card.new
    end
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
    @phone_number = session[:phone_number]
    @id = @phone_number["id"]
    @myphone = PhoneNumber.find_by(id: @id).phone_number
    @yournumber = TakeLog.find_by(ip_address: @myphone ,card_id: @card)
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







end

