class CathaybkController < ApplicationController
  before_action :set_gmap, only: [:show, :edit, :update, :destroy]
  def index
    @select = Select.first
  end

  def basic
    @select = Select.first
  end
  def situation
    @select = Select.first
    @gmaps = Bank.all
      @hash = Gmaps4rails.build_markers(@gmaps) do |gmap, marker|
        marker.lat gmap.latitude
        marker.lng gmap.longitude
        marker.infowindow gmap.address
      end
  end

  def credit
    @select = Select.first
  end


  def new
    @gmap = Bank.new
  end

 
  def edit
  end

  
  def create
    @gmap = Bank.new(gmap_params)

    
      if @gmap.save
        redirect_to situation_path
      else
        render :new 
       
      end
    
  end


  def update
    
      if @gmap.update(gmap_params)
        redirect_to situation_path
      else
        render :edit 
        
      end
    
  end


  def destroy
    @gmap.destroy
    redirect_to situation_path
  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gmap
      @gmap = Bank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gmap_params
      params.require(:bank).permit(:latitude, :longitude, :address)
    end
end
