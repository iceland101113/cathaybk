class CathaybkController < ApplicationController
  before_action :set_gmap, only: [:show, :edit, :update, :destroy]

  
   #before_action :authorize
  


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

      session[:phone_number] = nil

      #抓取使用者所在位置，使用http://freegeoip.net/json/這個API來把IP轉成經緯度
      @your_ip = request.ip
      if @your_ip.to_s == '127.0.0.1'
        o_ip = '140.112.1.1'
      else
        o_ip = @your_ip.to_s
      end
      
      ip_url = 'http://freegeoip.net/json/'+ o_ip
      ip_response = RestClient.get(ip_url)
      ip_data = JSON.parse(ip_response.body)
      @ip_lat = ip_data["latitude"]
      @ip_lng = ip_data["longitude"]


      #計算使用者到各個分行的距離，並計算最短距離的分行為何，使用Google Maps Distance Matrix API回傳使用者位置與各分行距離與到達時間
      bank=['國泰世華 西門分行','國泰世華 台北分行', '國泰世華 大安分行', '國泰世華 安和分行']
      bank_p=[[25.040818, 121.504449], [25.044361, 121.511745], [25.040298, 121.545906], [25.030499, 121.550283]]
      
      destinations='25.040818%2C121.504449%7C25.044361%2C121.511745%7C25.040298%2C121.545906%7C25.030499%2C121.550283'
      origins=@ip_lat.to_s+','+@ip_lng.to_s

      url = 'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins='+origins+'&destinations='+destinations+'&key=AIzaSyAFGz_0KE-4QFRP2yG2v-cwS27CPCt8UcQ'

      response = RestClient.get(url)
      data = JSON.parse(response.body)
      bank_num = bank.length
      data1=[]
      data2=[]
      for i in 1..bank_num
        b_distance = data["rows"][0]["elements"][i-1]["distance"]["value"]
        b_duration = data["rows"][0]["elements"][i-1]["duration"]["value"]
        data1.push(b_distance)
        data2.push(b_duration)
      end
        b_where = data1.index(data1.min)
        @bank_near_name = bank[b_where]
        @bank_near = bank_p[b_where]
        @bank_distance = data1[b_where]
        @bank_duration = data2[b_where]/60 

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
