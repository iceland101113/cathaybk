class CardsController < ApplicationController





 before_action :set_card, only: [:update, :destroy, :show]


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
    
  end


    def destroy
      
      @card.destroy
     
      redirect_to admin_cards_path
    end


  private

  def card_params
    params.require(:card).permit(:title)
  end

  def set_card
    @card = Card.find(params[:id])
  end







end

