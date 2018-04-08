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

    # @basic.each_value do |value|
    #   puts value.to_f
    # end

    
    @point_basic = @basic.age.to_f + @basic.education.to_f + @basic.marriage.to_f + @basic.house.to_f + @basic.job.to_f + @basic.job_title.to_f + @basic.longevity.to_f + @basic.income.to_f
    @month_money = @basic.income.to_f
    # @point = 0
    # @basic[:age]
    # @basic.each_value { |value|  @point + value.to_f }
    session[:point] = @point_basic
    session[:month_money] = @month_money
    
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
    @credit = Credit.create(credit_params)
    @point_credit = @credit.credit_num.to_f + @credit.credit_time.to_f + @credit.credit_money.to_f + @credit.credit_all_money.to_f + @credit.credit_last.to_f 
                    + @credit.credit_new.to_f + @credit.credit_current_money.to_f + @credit.credit_current_all_money.to_f + @credit.repay_month.to_f
    
    session[:point] = session[:point] + @point_credit

    if @credit.save
      
      redirect_to situation_path, notice: "試算成功"
    else
      render 'credit', notice: "填入資料有誤"
      
    end
  end

  def situation
      @select = Select.first
      case session[:point]
       when 90..101
        session[:point] == 18
       when 80..90
        session[:point]  == 15
       when 70..80
        session[:point] ==10
       when 60..70
        session[:point] == 8
       else 
        session[:point]  == 5
      end

      case session[:month_money]
      when 2
        session[:month_money] = 28000
      when 3
        session[:month_money] = 31000
      when 4
        session[:month_money] = 38000
      when 5
        session[:month_money] = 46000
      when 5.1
        session[:month_money] = 56000
      when 5.2
        session[:month_money] = 73000
      when 6
        session[:month_money] = 110000
      else 6.1
        session[:month_money] = 125000
      end

       @total_money =  session[:point] * session[:month_money] 
      
      

      # session[:phone_number] = nil


      @address = Addresslanlng.new

  end

  def result  
    weight = params[:body_weight].to_f

      # BMI 計算公式: BMI = 體重（單位：公斤） / 身高平方（單位：公尺）.
    @bmi = (weight).round(2)
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

    @address = Addresslanlng.new(add_param)

      if @address.save
        redirect_to situation_path
      else
        render :new        
      end 

    
  end

  def pos
    @ip_lat = params[:lat]
    @ip_lng = params[:lon]

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

      @address = Addresslanlng.new

      render :json => { :lat => @ip_lat, :lng=> @ip_lon, :near_bank=> @bank_near, :bank_near_name=> @bank_near_name, :bank_distance=> @bank_distance, :bank_duration=> @bank_duration }

  end

  def user_pos

    @address = Addresslanlng.create(add_param)

    if @address.save
      @ip_lat = Addresslanlng.last.latitude
      @ip_lng = Addresslanlng.last.longitude


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

      render :json => { :lat => @ip_lat, :lng=> @ip_lng, :near_bank=> @bank_near, :bank_near_name=> @bank_near_name, :bank_distance=> @bank_distance, :bank_duration=> @bank_duration }
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

    def set_address
        @address = Addresslanlng.new
    end
    

    def add_param
      params.require(:addresslanlng).permit(:address)
    end

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
