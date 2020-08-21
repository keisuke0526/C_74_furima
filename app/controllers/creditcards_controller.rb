class CreditcardsController < ApplicationController
  require "payjp"
  
  before_action :set_item, only:[:show, :pay]
  before_action :card_present,only:[:index,:destroy]
  before_action :take_card, only:[:show, :pay]
  before_action :set_customer, only:[:index, :destroy]
  before_action :set_card_infomation, only:[:index]
  before_action :set_api_key

  def index
    if @card
      @card_brand = @card_infomation.brand
      #画像を保存して使用した方がいいのか？
      case @card_brand
      when "Visa"
        @card_image = "https://www-mercari-jp.akamaized.net/assets/img/card/visa.svg?238737266"
      when "MasterCard"
        @card_image = "https://www-mercari-jp.akamaized.net/assets/img/card/master-card.svg?238737266"
      when "Saison" 
        @card_image = "https://www-mercari-jp.akamaized.net/assets/img/card/saison-card.svg?238737266"
      when "JCB"
        @card_image = "https://www-mercari-jp.akamaized.net/assets/img/card/jcb.svg?238737266"
      when "American Express"
        @card_image = "https://www-mercari-jp.akamaized.net/assets/img/card/american_express.svg?238737266"
      when "Diners Club"
        @card_image = "https://www-mercari-jp.akamaized.net/assets/img/card/dinersclub.svg?238737266"
      when "Discover"
        @card_image = "https://www-mercari-jp.akamaized.net/assets/img/card/discover.svg?238737266"
      end
    end
  end

  def new
  end
  

  def create
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_PRIVATE_KEY]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      user_id = current_user.id
      customer = Payjp::Customer.create(card: params['payjp-token'])
      @card = Creditcard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        flash[:notice] = 'カード情報を登録しました'
        redirect_to "/"
      else
        flash[:alert] = 'カード情報を登録できませんでした'
        redirect_to action: "new"
      end
    end
  end

  def show
    if @card.blank?
      flash[:alert] = 'カード情報を登録してください'
      redirect_to creditcards_path
    else
      set_customer
      set_card_infomation
    end
  end

  def destroy
    @customer.delete
    if @card.destroy
      flash[:notice] = '削除しました'
      redirect_to action: "index"
    else
      flash[:alert] = '削除できませんでした'
      redirect_to action: "index"
    end
  end

  def pay
    @item.update(buyer_id: current_user.id)
    Payjp::Charge.create(
      amount: 1000,
      customer: @card.customer_id,
      currency: 'jpy'
    )
    redirect_to item_purchase_index_path(@item.id) #購入確認画面へ遷移
  end

  private

  def set_api_key
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_PRIVATE_KEY]
  end
  
  def set_item
   # @item = Item.find(params[:id])
   # @address = Address.find_by(user_id: current_user.id)
  end

  def card_present
    @card = Creditcard.where(user_id: current_user.id).first if Creditcard.where(user_id: current_user.id).present?
  end

  def set_customer
    @customer = Payjp::Customer.retrieve(@card.customer_id)
  end

  def set_card_infomation
    @card_infomation = @customer.cards.retrieve(@card.card_id)
  end

  def take_card
    @card = Creditcard.find_by(user_id: current_user.id)
  end
end