class CathaybkController < ApplicationController
  before_action :set_gmap, only: [:show, :edit, :update, :destroy]

  before_action :authorize
  


  def index
    @select = Select.first
  end

  #基本資料
  def basic
   @basic = Basic.new

    
  end

  def basic_submit
    @basic = Basic.new(basic_params)
    if @basic.save
      redirect_to '/credit'
    else 
      render 'basic'
      flash[:notice] = "填入資料有誤"
    end
  end

  #信用嘅＆貸款資訊
  def credit
   
      @credit = Credit.new

  end

  def credit_submit
    @credit = Credit.new(credit_params)
    if @credit.save
      flash[:success] = "試算成功"
      redirect_to "/situation"
    else
      render 'credit'
      flash[:notice] = "填入資料有誤"
    end
  end

  def situation
  
      @select = Select.first
      @gmaps = Bank.all
        @hash = Gmaps4rails.build_markers(@gmaps) do |gmap, marker|
          marker.lat gmap.latitude
          marker.lng gmap.longitude
          marker.infowindow gmap.address
        end


       session[:phone_number] = nil
  end

  def credit
    @credit = Credit.new
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

    def basic_params
      params.require(:basic).permit(:age, :education, :marriage, :house, :job, :job_title, :longevity, :income)
    end

    def credit_params
      params.require(:credit).permit(:credit_num, :credit_time, :credit_money, :credit_all_money, :credit_last, :credit_new, :credit_current_money, :credit_current_all_money, :repay_month)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gmap_params
      params.require(:bank).permit(:latitude, :longitude, :address)
    end
     def authorize
      if session[:phone_number] == nil
        redirect_to root_path, notice: "請電話驗證"
      end
    end
end
