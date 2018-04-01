require 'rails_helper'

RSpec.describe User, type: :model do
  describe "登入系統" do
    before do
      @user = User.create(email: "123456@xxx.com", name: "Dex")
    end
    it "必須有信箱" do
      expect(@user.email).to eq("123456@xxx.com")
    end
    it "必須有姓名"do
      expect(@user.name).to eq("Dex")
    end

  end

end