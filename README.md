# 國泰世華 - 打造 in-branch banking O2O 新體驗

## 網站功能

### 填電話號碼
- 傳入手機號碼
- sever會發送一組認證碼到手機(4位數字)
- 認證成功後登入
- 一組號碼只能登入3次

### 問卷
- 填寫問券
- 如果有問題沒回答,提醒使用者回答
- 試算可以借貸金額


### 問卷結果
- 顯示出可信貸金額
- 試算金額Slider
- google map 顯示出最近的分行,並規劃路線

### 抽號碼牌
- 登入信箱
- 選擇排隊時間
- 抽號碼牌
- sever傳號碼和時間到email和手機

### 管理者
- 取消已經服務完號碼
- 移動號碼牌排序
- 提醒客戶快輪到他了


##  部署ＧＣＰ
因為要給現場使用者體驗,先把twilio api 拿掉



## 特別使用的gem及api        

* [twilio-ruby](https://github.com/twilio/twilio-ruby)  
--使用者手機認證功能 

* [gmaps4rails](https://github.com/apneadiving/Google-Maps-for-Rails)
--用來繪製google map地圖以及將分行位置顯示在地圖上以及定出使用者位置

* [geocoder](https://github.com/alexreisner/geocoder)
--用來將使用者輸入的地址轉為坐標

* [Google Maps Distance Matrix API](https://developers.google.com/maps/documentation/distance-matrix/intro?hl=zh-tw)
--計算輸入地址最近分行或使用者位置最近分行的距離以及要多少旅行時間到達, 本專案使用步行時間,  此api亦提供開車,腳踏車等多種交通工具旅行方式計算旅行時間

* [Google Maps Directions API](https://developers.google.com/maps/documentation/directions/start?hl=zh-tw)
--路徑規劃, 計算位置以及最近分行最短路徑並繪出

* [jquery-rails](https://github.com/rails/jquery-rails)  
* [bootstrap-sass](https://github.com/twbs/bootstrap-sass)  
--用來撰寫一些前端效果時需要用到,  例如問卷表單美化, 頁面RWD  
--地址定位以及使用者最近分行定位使用jQuery ajax的方式將坐標傳回後端運算

* [bootstrap-slider-rails](https://github.com/stationkeeping/bootstrap-slider-rails)
--用來做出月付金試算的拖拉軸小工具, 介面參考w3shool的[How TO - Range Sliders](https://www.w3schools.com/howto/howto_js_rangeslider.asp)

* [rspec-rails](https://github.com/rspec/rspec-rails)  
--用來做網站測試
 
