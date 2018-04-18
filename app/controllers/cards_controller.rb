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
    @phone_number = current_phone.phone_number.to_i
    @people = Card.where("title LIKE ? AND  date LIKE ?", @card.title  , @card.date).size
    puts @people
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
          # @client = Twilio::REST::Client.new('ACd1ddc0ae6cb57f040340cd6b205a284e', '1bc8ca6228ee5625cf1abc35792eab51')
    
          # @client.messages.create(
          #   from: '+16144125358',
          #   to: "+886#{@phone_number}",
          #   body: message
          # )
          end
        redirect_to card_path(@card.id), notice: "預約成功,請看簡訊或者信箱"
    
    
      else
        redirect_to cards_path, notice: "預約失敗"
      end
     end 
  end

  def get_time
    date = params[:date]
    @people = Card.where("date LIKE ?",date)
    puts @people.size
    @time1 = @people.where("title LIKE ?",'08:00-09:00').size
    @time2 = @people.where("title LIKE ?",'09:00-10:00').size
    @time3 = @people.where("title LIKE ?",'10:00-11:00').size
    @time4 = @people.where("title LIKE ?",'11:00-12:00').size
    @time5 = @people.where("title LIKE ?",'12:00-13:00').size
    @time6 = @people.where("title LIKE ?",'13:00-14:00').size
    @time7 = @people.where("title LIKE ?",'14:00-15:00').size
    puts @time1
puts @time2
puts @time3
puts @time4
puts @time5
puts @time6
puts @time7
    render :json => { :time1 => @time1, :time2 => @time2, :time3 => @time3, :time4 => @time4, :time5 => @time5, :time6 => @time6, :time7 => @time7 }
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